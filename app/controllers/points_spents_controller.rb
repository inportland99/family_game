class PointsSpentsController < ApplicationController
  before_filter :authenticate_user_or_student

  helper_method :sort_column, :sort_direction

  # GET /points_spents
  # GET /points_spents.json
  def index
    @points_spents = PointsSpent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points_spents }
    end
  end

  # GET /points_spents/1
  # GET /points_spents/1.json
  def show
    @points_spent = PointsSpent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @points_spent }
    end
  end

  # GET /points_spents/new
  # GET /points_spents/new.json
  def new
    @points_spent = PointsSpent.new
    @student = Student.find(params[:student_id]) if params[:student_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @points_spent }
    end
  end

  # GET /points_spents/1/edit
  def edit
    @points_spent = PointsSpent.find(params[:id])
  end

  # POST /points_spents
  # POST /points_spents.json
  def create
    @points_spent = PointsSpent.new(params[:points_spent])

    # Ensure user has enough points to make the purchase
    @student = Student.find(params[:points_spent][:student_id])
    @reward = Reward.find(params[:points_spent][:reward_id])
    if (@student.xp_gained - @student.xp_used) >= @reward.xp_cost
      # Set points_spent.xp_spent based on the reward chosen
      @points_spent.xp_spent = @reward.xp_cost
    end

    respond_to do |format|
      if !@points_spent.xp_spent.nil?
        if @points_spent.save
          flash[:success] = 'Reward granted. Points Spent.'
          format.html { redirect_to student_path(params[:points_spent][:student_id]) }
          format.json { render json: @points_spent, status: :created, location: @points_spent }
        else
          format.html { render action: "new" }
          format.json { render json: @points_spent.errors, status: :unprocessable_entity }
        end
      else
          flash[:error] = 'Not enough points to purchase selected reward.'
          format.html { redirect_to student_path(params[:points_spent][:student_id]) }
      end
    end
  end

  # PUT /points_spents/1
  # PUT /points_spents/1.json
  def update
    @points_spent = PointsSpent.find(params[:id])

    respond_to do |format|
      if @points_spent.update_attributes(params[:points_spent])
        format.html { redirect_to @points_spent, notice: 'Points spent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @points_spent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points_spents/1
  # DELETE /points_spents/1.json
  def destroy
    @points_spent = PointsSpent.find(params[:id])
    @points_spent.destroy

    respond_to do |format|
      format.html { redirect_to points_spents_url }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # def authenticate_user_or_student
  #   if current_student
  #     authenticate_student!
  #   else
  #     authenticate_user!
  #   end
  # end

end
