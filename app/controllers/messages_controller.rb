class MessagesController < ApplicationController

  SYSTEM_PROMPT = "
    You are an experienced Building Manager, specialised in Belgium Co-ownerships.

    I am an appartement Owner, looking to learn about the Co-Ownership rules and regulations.

    I will provide you with context that should support your advice.

    Provide step-by-step instructions in bullet points, using Markdown.
  "

  def create
    # Gets the user message from params and assigns it to user_message.
    @chat = Chat.find(params[:chat_id])
    @section = @chat.section
    
    # Use following line instead of above line when our devise login will work
    # @chat = current_user.chats.find(params[:chat_id])
    message = params[:message]
    @user_message = Message.new(content: message[:content], role: 'user', chat: @chat)
    
    if @user_message.save
      #Creates an empty assistant message reply
      @assistant_message = @chat.messages.create(content: "", role: 'assistant')

      send_question

      # Get responses of chat
      @assistant_message.update(content: @response.content)
      broadcast_replace(@assistant_message)

      # adapt title of the chat
      @chat.generate_title_from_first_message

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(
          :new_message, partial: "messages/form", locals: { chat: @chat, message: user_message }
        ) }
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def build_conversation_context
    instructions = [SYSTEM_PROMPT, @section.content, @section.system_prompt].compact.join("\n\n")
    @ruby_llm_chat.with_instructions(instructions)
  end

  def build_conversation_history
    @chat.messages.each do |msg|
      next if msg.content.blank?

      @ruby_llm_chat.add_message(msg)
    end
  end

  def send_question
    # Generates AI response with chat.ask and assigns it to ai_message.
    @ruby_llm_chat = RubyLLM.chat

    # Add context from section to message
    build_conversation_context

    # Calling Build_conversation_history method
    build_conversation_history

    @response = @ruby_llm_chat.ask(@user_message.content) do |chunk|
      next if chunk.content.blank?

      @assistant_message.content += chunk.content
      broadcast_replace(@assistant_message)
    end
  end

  def broadcast_replace(message)
    Turbo::StreamsChannel.broadcast_replace_to(@chat, 
      target: helpers.dom_id(message),
      partial: "messages/message",
      locals: { message: message })
  end
end
