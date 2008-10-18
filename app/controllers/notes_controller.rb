class NotesController < ApplicationController
  def show
    @note = current_project.notes.find(params[:id])
  end
  
  def new
    @note = current_project.notes.build
  end
  
  def create
    @note = current_project.notes.build(params[:note])
    if @note.save
      flash[:notice] = "Successfully created note."
      record_activity "Added #{@note} note to #{current_project} project"
      redirect_to project_note_url(current_project, @note)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @note = current_project.notes.find(params[:id])
  end
  
  def update
    @note = current_project.notes.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:notice] = "Successfully updated note."
      record_activity "Updated #{@note} note in #{current_project} project"
      redirect_to project_note_url(current_project, @note)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @note = current_project.notes.find(params[:id])
    @note.destroy
    flash[:notice] = "Successfully destroyed note."
    record_activity "Removed #{@note} note from #{current_project} project."
    redirect_to current_project
  end
end
