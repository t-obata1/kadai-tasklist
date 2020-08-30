class TasksController < ApplicationController
  before_action :correct_user, only:  [:show, :edit, :destroy]
  before_action :require_user_logged_in, only: [:index, :show, :destroy]


  
  #以前のbeforeアクション
  # before_action :set_task,  only: [:show,:edit,:update,:destroy]
  # before_action :correct_user, only: [:destroy]
  # before_action :require_user_logged_in, only: [:index, :show, :destroy]

  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end

  def show

  end  
  
  def new
    @task = Task.new
  end
  
  def create
  @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'tasks/new'
    end
  end  
  
  def edit

  end
    
  def update
    if @task.update(task_params)
      flash[:success] = "メッセージは正常に更新されました"
      redirect_to root_url
    else
      flash.now[:danger] = "タスクが更新されませんでした"
      render :edit
    end
  end
    
  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to root_url
 
  end
  
private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
end