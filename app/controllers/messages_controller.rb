class MessagesController < ApplicationController

  def create
    # Gets the user message from params and assigns it to user_message.
    @chat = Chat.find(params[:chat_id])
    # Use following line instead of above line when our devise login will work
    # @chat = current_user.chats.find(params[:chat_id])
    message = params[:ai_messages]
    user_message = @chat.messages.new(content: message[:content], role: 'user')

    if user_message.save
      # Generates AI response with chat.ask and assigns it to ai_message.
      @ruby_llm_chat = RubyLLM.chat

      # Calling Build_conversation_history method
      build_conversation_history
      response = @ruby_llm_chat.ask(user_message.content)
      airesp = Message.create(content: response.content, role: 'assistant', chat: @chat)
    end

    redirect_to @chat
  end

  def build_conversation_history

    @chat.messages.each do |msg|
      @ruby_llm_chat.add_message(msg)
    end
  end
end
