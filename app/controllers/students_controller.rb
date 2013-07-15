class StudentsController < ApplicationController
  before_filter :authenticate_user_or_student

  # allow acces to these functions in the view using helper_method
  helper_method :sort_column, :sort_direction

  # GET /students
  # GET /students.json
  def index
    @students = Student.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /studens/1
  # GET /studens/1.json
  def show
    @student = Student.find(params[:id])
    @points_feed = Point.where("student_id  = ? AND updated_at > ?", @student.id, 1.days.ago ).order('created_at desc').limit('20')
    @points_spent_feed = PointsSpent.where("student_id  = ? AND updated_at > ?", @student.id, 7.days.ago ).order('created_at desc').limit('20')

    # Create list of activities that have not been done in the last 24 hours
    @todo = Activity.all
    @points_feed.each do |activity_completed|
      @todo.reject!{ |act| act.id == activity_completed.activity_id}
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    # unless current_student.role == "Admin" || current_student.id == @student.id
    #   flash[:error] = 'You can not edit selected student.'
    #   redirect_to students_path
    # end
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path, notice: 'student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end


  private

  def authenticate_user_or_student
    if current_student
      authenticate_student!
    else
      authenticate_user!
    end
  end

  # def authorize_student
  #   @student = student.find(params[:id])
  #   unless current_user.admin? || current_student.id == @student.id
  #     flash[:error] = 'You can not edit selected student.'
  #     redirect_to students_path
  #   end
  # end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
