class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to note_path(@note),notice: '投稿に成功しました！！'
    else
      render :new
    end    
  end

  def edit
    @note = Note.find(params[:id])
    if @note.user != current_user
      redirect_to notes_path,alert:'不正なアクセスです！！'
    end  
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to note_path(@note), notice: '更新に成功しました！！'
    else
      render :edit
    end    
  end 

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to notes_path
  end  

  private
  def note_params
    params.require(:note).permit(:title, :body, :image)
  end  

end
