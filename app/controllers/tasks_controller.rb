class TasksController < ApplicationController
    before_action :set_task, only: %i[ show edit update destroy ]

    def new
        @task = Task.new
    end

    def index
        @tasks = Task.all
    end

    def show 
    end

    def edit
    end

    def create
        @task = Task.new(task_params)
    
        respond_to do |format|
          if @task.save
            format.html { redirect_to task_path(@task), notice: "タスクの新規登録に成功しました" }
        
          else
            format.html { render :new, status: :unprocessable_entity }
            
          end
        end
      end

    # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_path(@task), notice: "タスクの更新に成功しました" }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクの削除に成功しました" }
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description)
    end

    
end
