class TasksController < ApplicationController
  # before_action :set_task,  only: [:show,:edit,:update,:destroy]
  before_action :correct_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:index, :show,]
  
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
    # @tasks = Task.order(id: :desc).all.page(params[:page]).per(20) #インスタンス変数 = モデル名.allを代入
  
  def show
    #set_task
    #@task = Task.find(params[:id])
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
      render 'tasks/index'
    end
  end  
  
  def edit
    #set_task
    #@task = Task.find(params[:id])

  end
    
  def update
    #set_task
    #@task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "メッセージは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが更新されませんでした"
      render :edit
    end
  end
    
  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
 
  end
  
private

  # def set_task
  #   @task = Task.find(params[:id])
  # end
  
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