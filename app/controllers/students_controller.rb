class StudentsController < ApplicationController
  before_action :authorize_request!
	before_action :find_student,only: [:show,:update,:destroy]
	def  index
	 if params[:search].present?
  		@students = Student.where("lower(roll_number) LIKE ? OR lower(firstname) LIKE ? OR lower(last_name) LIKE ?", "%#{params[:search].strip.downcase}%", "%#{params[:search].strip.downcase}%", "%#{params[:search].strip.downcase}%").paginate(page: params[:page], per_page: 10)
  	else
  		@students = Student.all.paginate(page: params[:page], per_page: 20)
  	end
		render json: {data: @students, message: "Student lists", meta: {total_page: @students.total_pages}}
	end
	def student_search
  	if params[:search].present?
  		@students = Student.where("lower(roll_number) LIKE ? OR lower(firstname) LIKE ? OR lower(last_name) LIKE ?", "%#{params[:search].strip.downcase}%", "%#{params[:search].strip.downcase}%", "%#{params[:search].strip.downcase}%").paginate(page: params[:page], per_page: 10)
  	else
  		@students = Student.all.paginate(page: params[:page], per_page: 3)
  	end
		render json: {data: @students, message: "Student lists", meta: {total_page: @students.total_pages}}
  end
	def show
		render json: {data: @student, message: "student create sussefully"}
	end
	def create
		@student = Student.new(student_params)
		if @student.save
			 render json: {data: @student, message: "student create sussefully"}
		 else
			 return render json: {error: @student.errors}, student: :unprocessable_entity
		end
	end
	def update
		@student.update(student_params)
    render json: {data: @student}
	end
	def destroy
		@student.destroy
    render json: {message: 'student destroy sussefully'}		
	end
	private
	def find_student
		@student = Student.find_by(id: params[:id]) 
    if @student.nil?
      return render json: {error: "student not found"}, status: :not_found
    end 
	end
	def student_params
		params.require(:student).permit(:firstname, :last_name, :roll_number, :district, :branch, :active)
	end
end
