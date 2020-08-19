class TasksController < ApplicationController

    before_action :require_user_logged_in, only: [:show,:new, :create, :edit, :update, :destroy]
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new 
        @task = current_user.tasks.build(params[:content])
    end
    
    def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを追加しました。'
      redirect_to root_url
    else
      @tasks = Task.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの追加に失敗しました。'
      render :new
    end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "タスクが編集されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクの編集に失敗しました"
            render :edit 
        end
    end
    
    
      def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash.now[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_path
      end
     
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
     
end
