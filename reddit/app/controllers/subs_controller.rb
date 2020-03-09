class SubsController < ApplicationController
  before_action :ensure_logged_in 
  
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id 
    if @sub.save
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to subs_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end 

  end

  def index
    @subs = Sub.all 
    render :index
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end