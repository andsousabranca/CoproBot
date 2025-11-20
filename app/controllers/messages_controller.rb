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
    user_message = Message.new(content: message[:content], role: 'user', chat: @chat)

    if user_message.save
      # Generates AI response with chat.ask and assigns it to ai_message.
      @ruby_llm_chat = RubyLLM.chat

      # Add context from section to message
      build_conversation_context

      # Calling Build_conversation_history method
      build_conversation_history

      # Get responses of chat
      response = @ruby_llm_chat.ask(user_message.content)
      Message.create(content: response.content, role: 'assistant', chat: @chat)

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
      @ruby_llm_chat.add_message(msg)
    end
  end
end
