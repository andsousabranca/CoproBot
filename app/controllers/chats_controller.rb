class ChatsController < ApplicationController

  def create
    @section = Section.find(params[:section_id])
    @chat = Chat.new(title: @section.name, section_id: @section.id, user_id: 1)

    if @chat.save
      redirect_to chat_path(@chat)
    end
  end


    def show
    @chat = Chat.find(params[:id])
    @section = @chat.section
    @user = @chat.user
    @message = Message.new()

    # get all the current and historic chats of the section
    @chats = @section.chats.order(created_at: :desc)
  end

  def chat_params
    params.require(:chat).permit(:title)
  
  def create
    @section = Section.find_by(params[:id])

    # initialize @chat variable with last chat
    @chat = Chat.last
    
    # check if that chat alredy has some messages, if yes, then it is a used chat, hence we have to create a new one
    if @chat.messages.any?
      @chat = Chat.create!(user: current_user, section: @section, title: "New chat")
    end

    raise
  end

end
