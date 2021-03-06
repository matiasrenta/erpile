class Income < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }


  belongs_to :user
  belongs_to :project
  belongs_to :cash_closing

  STATUS_CREATED      = 'CREATED'
  STATUS_ACCOUNTED    = 'ACCOUNTED'

  STATUS_TYPES = [['CREADO', STATUS_CREATED],
                  ['CONTABILIZADO', STATUS_ACCOUNTED]]

  scope :by_project, -> (project_id){where(project_id: project_id)}
  scope :by_cash_closing, -> (cash_closing_id){where(cash_closing_id: cash_closing_id)}
  scope :created, -> {where(status: STATUS_CREATED)}

  before_validation on: :create do
    self.status = STATUS_CREATED
  end

  validates :concept, :amount, :fecha, :user_id, :status, presence: true
  validates :amount, :user_id, numericality: true


  #un array con solo los status que van a la bbdd
  def self.system_status_array
    STATUS_TYPES.map{|s| s[1]}
  end

  def self.i18n_status(status)
    STATUS_TYPES.find { |st| st[1] == status}[0]
  end

  def created?
    self.status == STATUS_CREATED
  end

  def i18n_status
    STATUS_TYPES.find { |e| e[1] == self.status}[0]
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
