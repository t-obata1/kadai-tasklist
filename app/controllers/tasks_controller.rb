class TasksController < ApplicationController
  before_action :correct_user, only:  [:show, :edit, :update, :destroy] #ログインユーザが所持しているタスクか確認
  before_action :require_user_logged_in, only: [:index, :show, :new, :edit, :create, :update, :destroy] #ログインしていれば何もせず、ログインしていなければログインページへ強制的にリダイレクト

  
  #以前のbeforeアクション
  # before_action :correct_user, only: [:show, :edit, :destroy]
  # before_action :require_user_logged_in, only: [:index, :show, :destroy]

  def index
    # if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    
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

# before_action :correct_user, only: [:destroy] によって、destroy アクションが実行される前に correct_user が実行されます。
# correct_user メソッドでは、削除しようとしている Micropost が本当にログインユーザが所有しているものかを確認しています。
# 誰もが勝手に他者の投稿を削除できないようにするための対処です。
# 具体的には current_user.microposts.find_by(id: params[:id]) によって、ログインユーザ (current_user) が持つ microposts 限定で検索しています。
# これで見つかれば、ちゃんとログインユーザの Micropost の id であったと確認できますので、そのまま何もしません。
# 見つからなかった場合、nil が代入されいるので unless @micropost で nil を判定しています。if文は nil か false のとき実行されず、
# unless文は nil か false のときに実行されます。見つからなければ redirect_to root_url によってトップページに戻されます。