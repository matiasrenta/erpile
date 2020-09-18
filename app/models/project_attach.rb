class ProjectAttach < ActiveRecord::Base
  belongs_to :project

  attachment :file, store: 's3_project_attach_backend', cache: 's3_project_attach_cache'

  #validates :project_id, :file_id, :file_filename, :file_size, presence: true
  #validates :project_id, :file_size, numericality: true

  after_destroy :remove_file

  private

  def remove_file
    file.try(:delete)
  end
end
