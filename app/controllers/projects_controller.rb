class ProjectsController < ApplicationController

  def search
    page = params[:page] || 1
    @query  = params[:query]
    @projects = Project.where("name like ? or description like ?" , "%#{@query}%" , "%#{@query}%").page page
  end

  # GET /projects
  # GET /projects.json
  def index
    page = params[:page] || 1
    
    if params[:tag]
      @projects = Project.tagged_with(params[:tag]).page
    else
      @projects = Project.page page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @logs = @project.logs

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  def sync
    @project = Project.find(params[:id])
    if @project
      @result = Synchronizer.sync @project
    end
    
    respond_to do |format|
      format.html{ redirect_to @project, notice: "Project synced."}
      format.js
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
