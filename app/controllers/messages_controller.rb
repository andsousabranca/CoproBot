class MessagesController < ApplicationController
    @chat = Chat.find(params[:chat_id])

    # USER MESSAGE
    message = params[:ai_messages][:content]
    user_message = @chat.messages.create(content: message, role: 'user')

    # AI MESSAGE
    chat = RubyLLM.chat
    response = chat.ask(user_message.content)
    ai_message = @chat.messages.create(content: response.content, role: 'ai')

    raise
    redirect_to @chat
  end

  # # def
  #   @chat = Chat.find(params[:chat_id])

  #   # Get user input
  #   user_content = params[:ai_messages][:content]

  #   # Save the user message
  #   user_message = @chat.messages.create!(content: user_content, role: 'user')

  #   # Ask RubyLLM
  #   llm = RubyLLM.chat
  #   llm_response = llm.ask(user_content)

  #   # Save the AI response as a message
  #   @chat.messages.create!(content: llm_response.content, role: 'ai')

  #   # Redirect back to chat show page
  #   redirect_to @chat
  # end
end
