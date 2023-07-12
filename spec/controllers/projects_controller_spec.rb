require 'spec_helper'

describe ProjectsController do

  let(:valid_attributes) { { "title" => "Title" } }

  let(:valid_session) { {} }
  #TODO split specs into 'logged in' vs 'not logged in'
  before :each do
    user = double('user')
    request.env['warden'].stub :authenticate! => user
    controller.stub :current_user => user
  end

  context '#index' do
    it 'should render index page for projects' do
      get :index
      expect(response).to render_template 'index'
    end

    it 'should assign variables to be rendered by view' do
      projects = [double(Project), double(Project)]
      Project.stub(:all).and_return(projects)
      get :index
      expect(assigns(:projects)).to eq projects
    end
  end

  context '#new' do
    it 'should render a new project page' do
      get :new
      expect(response).to render_template 'new'
    end
  end


  context '#create' do
    before(:each) do
      @params = {
          project: {
              id: 1,
              title: 'Title 1',
              description: 'Description 1',
              status: 'Status 1'
          }
      }
      @project = mock_model(Project, id: 1)
      Project.stub(:new).and_return(@project)
    end

    it 'redirects to show view on successful save' do
      @project.stub(:save).and_return(true)

      post :create, @params

      expect(response).to redirect_to(project_path(1))
      #TODO YA add a show view_spec to check if flash is actually displayed
      expect(flash[:notice]).to eql('Project was successfully created.')
    end
    it 'renders failure message on unsuccessful save' do
      @project.stub(:save).and_return(false)

      post :create, @params

      expect(response).to render_template :new
      expect(flash[:alert]).to eql('Project was not saved. Please check the input.')
    end
  end

  context '#destroy' do
    before :each do
      @project = double(Project)
      Project.stub(:find).and_return(@project)
    end
    it 'deletes a project' do
      expect(@project).to receive(:destroy)
      delete :destroy, :id => 'test'
    end
    it 'redirects to index' do
      allow(@project).to receive(:destroy)
      delete :destroy, :id => 'test'
      expect(response).to redirect_to(projects_path)
    end
    it 'raises exception if the project does not exist' do
      #TODO YA write implementation
      # unstub :find that was stubbed in before(:each)
      Project.stub(:find).and_call_original

      #expect { delete :destroy, :id => 'nonexistent project' }.to raise_error(ActiveRecord::RecordNotFound)
      delete :destroy, :id => 'nonexistent project'

      expect(response).to redirect_to(projects_path)
      expect(flash[:notice]).to eq 'Project not found.'
    end
  end

#TODO YA need to refactor the specs below, as there are duplication with the above specs
#TODO YA need to refactor to account for introduced model validations
  describe 'GET index' do
    it 'assigns all projects as @projects' do
      project = Project.create! valid_attributes
      get :index, {}, valid_session
      assigns(:projects).should eq([project])
    end
  end

  describe 'GET show' do
    it 'assigns the requested project as @project' do
      project = Project.create! valid_attributes
      get :show, {:id => project.to_param}, valid_session
      assigns(:project).should eq(project)
    end
  end

  describe 'GET new' do
    it 'assigns a new project as @project' do
      get :new, {}, valid_session
      assigns(:project).should be_a_new(Project)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested project as @project' do
      project = Project.create! valid_attributes
      get :edit, {:id => project.to_param}, valid_session
      assigns(:project).should eq(project)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Project' do
        expect {
          post :create, {:project => valid_attributes}, valid_session
        }.to change(Project, :count).by(1)
      end

      it 'assigns a newly created project as @project' do
        post :create, {:project => valid_attributes}, valid_session
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it 'redirects to the created project' do
        post :create, {:project => valid_attributes}, valid_session
        response.should redirect_to(Project.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved project as @project' do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "title" => "invalid value" }}, valid_session
        assigns(:project).should be_a_new(Project)
      end

      it 're-renders the new template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do

      it 'assigns the requested project as @project' do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        assigns(:project).should eq(project)
      end

      it 'redirects to the project' do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        response.should redirect_to(project)
      end
    end

    describe 'with invalid params' do
      it 'assigns the project as @project' do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "title" => "invalid value" }}, valid_session
        assigns(:project).should eq(project)
      end

      it 're-renders the edit template' do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested project' do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      project = Project.create! valid_attributes
      delete :destroy, {:id => project.to_param}, valid_session
      response.should redirect_to(projects_url)
    end
  end

end
