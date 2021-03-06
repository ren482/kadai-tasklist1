class TasksController < ApplicationController

    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :edit, :show, :update]
    
    def index
        @tasks = current_user.tasks
    end
    
    def show
        # @task = Task.find(params[:id])
    end
    
    def new 
        @task = current_user.tasks.build
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
        # @task = Task.find(params[:id])
    end
    
    def update
        @task = current_user.tasks.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスクが編集されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクの編集に失敗しました"
            render :edit 
        end
    end
    
    
      def destroy
    # @task = Task.find(params[:id])
    @task.destroy

    flash.now[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
      end
     
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to tasks_url
        end
    end
     
end
