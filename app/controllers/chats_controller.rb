class ChatsController < ApplicationController

  def create
    @section = Section.find(params[:section_id])

    # checks if sections has any chats, if yes, initialize @chat with the last one.
    if @section.chats.any?
      @chat = @section.chats.last

      # check if any messages in the chat, if yes, creates a new chat.
      if @chat.messages.any?
        @chat = Chat.new(title: @section.name, section_id: @section.id, user_id: current_user.id)
        @chat.save
      end
      redirect_to chat_path(@chat)

    # checks if sections doesn't have chats, initialize @chat with a new one.
    else
      @chat = Chat.new(title: @section.name, section_id: @section.id, user_id: current_user.id)
      if @chat.save
        redirect_to chat_path(@chat)
      end
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @section = @chat.section
    @message = Message.new

    # get all the current and historic chats of the section
    @chats = @section.chats.order(created_at: :desc)
  end

  def chat_params
    params.require(:chat).permit(:title)
  end
  
  # def create
  #   @section = Section.find_by(params[:id])

  #   # initialize @chat variable with last chat
  #   @chat = Chat.last
    
  #   # check if that chat alredy has some messages, if yes, then it is a used chat, hence we have to create a new one
  #   if @chat.messages.any?
  #     @chat = Chat.create!(user: current_user, section: @section, title: "New chat")
  #   end

  # end

end
