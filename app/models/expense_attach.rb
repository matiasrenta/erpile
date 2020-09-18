class ExpenseAttach < ActiveRecord::Base
  belongs_to :expense

  attachment :file, store: 's3_expense_attach_backend', cache: 's3_expense_attach_cache'

  #validates :expense_id, :file_id, :file_filename, :file_size, presence: true
  #validates :expense_id, :file_size, numericality: true

  after_destroy :remove_file

  private

  def remove_file
    file.try(:delete)
  end

end
