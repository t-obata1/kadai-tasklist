class TasksController < ApplicationController
  def index
    @tasks = Task.all #インスタンス変数 = モデル名.allを代入
  end
  
  def show
    @task = Task.find(params[:id])
  end  
  
  def new
    @task = Task.new()
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end  
  
  def edit
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが更新されませんでした"
      render :edit
    end
  end
    
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "メッセージは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが更新されませんでした"
      render :edit
    end  
  end
    
  def destroy
    @task = @Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクが削除されました"
    redirect_to tasks_url
  end
  
private #以下、このクラス内でのみ働くメソッド

  def task_params
    params.require(:task).permit(:content) 
  end
  
end