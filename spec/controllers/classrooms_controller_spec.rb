require 'rails_helper'

RSpec.describe ClassroomsController, :type => :controller do

  let(:domain)  { FactoryGirl.create :domain }
  let(:teacher) { FactoryGirl.create :user, :teacher => true, :domain_id => domain.id }

  let(:valid_attributes)   { FactoryGirl.attributes_for :classroom, :domain_id => domain.id }
  let(:invalid_attributes) { { :name => nil } }

  before { sign_in teacher }

  describe "GET index" do
    it "assigns all classrooms as @classrooms" do
      classroom = Classroom.create! valid_attributes
      get :index, {}
      expect(assigns(:classrooms)).to eq([classroom])
    end
  end

  describe "GET show" do
    it "assigns the requested classroom as @classroom" do
      classroom = Classroom.create! valid_attributes
      get :show, {:id => classroom.to_param}
      expect(assigns(:classroom)).to eq(classroom)
    end
  end

  describe "GET new" do
    it "assigns a new classroom as @classroom" do
      get :new, {}
      expect(assigns(:classroom)).to be_a_new(Classroom)
    end
  end

  describe "GET edit" do
    it "assigns the requested classroom as @classroom" do
      classroom = Classroom.create! valid_attributes
      get :edit, {:id => classroom.to_param}
      expect(assigns(:classroom)).to eq(classroom)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Classroom" do
        expect {
          post :create, {:classroom => valid_attributes}
        }.to change(Classroom, :count).by(1)
      end

      it "assigns a newly created classroom as @classroom" do
        post :create, {:classroom => valid_attributes}
        expect(assigns(:classroom)).to be_a(Classroom)
        expect(assigns(:classroom)).to be_persisted
      end

      it "redirects to the created classroom" do
        post :create, {:classroom => valid_attributes}
        expect(response).to redirect_to(Classroom.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved classroom as @classroom" do
        post :create, {:classroom => invalid_attributes}
        expect(assigns(:classroom)).to be_a_new(Classroom)
      end

      it "re-renders the 'new' template" do
        post :create, {:classroom => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { { :name => "new name" } }

      it "updates the requested classroom" do
        classroom = Classroom.create! valid_attributes
        put :update, {:id => classroom.to_param, :classroom => new_attributes}
        classroom.reload
        expect(classroom.name).to eq new_attributes[:name]
      end

      it "assigns the requested classroom as @classroom" do
        classroom = Classroom.create! valid_attributes
        put :update, {:id => classroom.to_param, :classroom => valid_attributes}
        expect(assigns(:classroom)).to eq(classroom)
      end

      it "redirects to the classroom" do
        classroom = Classroom.create! valid_attributes
        put :update, {:id => classroom.to_param, :classroom => valid_attributes}
        expect(response).to redirect_to(classroom)
      end
    end

    describe "with invalid params" do
      it "assigns the classroom as @classroom" do
        classroom = Classroom.create! valid_attributes
        put :update, {:id => classroom.to_param, :classroom => invalid_attributes}
        expect(assigns(:classroom)).to eq(classroom)
      end

      it "re-renders the 'edit' template" do
        classroom = Classroom.create! valid_attributes
        put :update, {:id => classroom.to_param, :classroom => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT/PATCH enroll" do
    let(:student)   { FactoryGirl.create :user, :active => true, :domain => domain }
    let(:classroom) { FactoryGirl.create :classroom, :domain => domain, :users => [teacher, student] }

    it "adds a student specified by id to the classroom" do
      new_student = FactoryGirl.create :user, :active => true, :domain => domain
      put :enroll, :id => classroom.to_param, :users => {
        :id => [ new_student.id ]
      }

      expect(classroom.students).to include(new_student)
      expect(response).to be_success
    end

    it "responds with a class list" do
      new_student = FactoryGirl.create :user, :active => true, :domain => domain
      put :enroll, :id => classroom.to_param, :users => {
        :id => [ new_student.id ]
      }
      classroom.reload
      expect(response.body).to eq({ :users => classroom.users }.to_json)
    end

    it "ignores students that are already enrolled" do
      expect(lambda do
        put :enroll, :id => classroom.to_param, :users => {
          :id => [ student.id ]
        }
      end).to_not change(classroom, :students)
    end
  end

  describe "PUT/PATCH withdraw" do
    let(:student)   { FactoryGirl.create :user, :active => true, :domain => domain }
    let(:classroom) { FactoryGirl.create :classroom, :domain => domain, :users => [teacher, student] }

    it "withdraws a student specified by id to the classroom" do
      put :withdraw, :id => classroom.to_param, :users => {
        :id => [ student.id ]
      }

      expect(classroom.students).to_not include(student)
      expect(response).to be_success
    end

    it "responds with a class list" do
      put :withdraw, :id => classroom.to_param, :users => {
        :id => [ student.id ]
      }
      classroom.reload
      expect(response.body).to eq({ :users => classroom.users }.to_json)
    end

    it "ignores students that are not enrolled" do
      new_student = FactoryGirl.create :user, :active => true, :domain => domain
      expect(lambda do
        put :withdraw, :id => classroom.to_param, :users => {
          :id => [ new_student.id ]
        }
      end).to_not change(classroom, :students)
    end
  end

    #  expect(classroom.students).to_not include(student)
    #  expect(response).to be_success
    #end

  describe "DELETE destroy" do
    it "destroys the requested classroom" do
      classroom = Classroom.create! valid_attributes
      expect {
        delete :destroy, {:id => classroom.to_param}
      }.to change(Classroom, :count).by(-1)
    end

    it "redirects to the classrooms list" do
      classroom = Classroom.create! valid_attributes
      delete :destroy, {:id => classroom.to_param}
      expect(response).to redirect_to(classrooms_url)
    end
  end

end
