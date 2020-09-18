class Project < ActiveRecord::Base
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

  STATUS_CREATED      = 'CREATED'
  STATUS_CHARGED      = 'CHARGED'
  STATUS_ACCOUNTED    = 'ACCOUNTED'
  STATUS_CANCELED     = 'CANCELED'

  STATUS_TYPES = [['CREADO', STATUS_CREATED],
                  ['COBRADO', STATUS_CHARGED],
                  ['CONTABILIZADO', STATUS_ACCOUNTED],
                  ['CANCELADO', STATUS_CANCELED]]

  has_many :expenses, dependent: :restrict_with_error
  has_many :incomes, dependent: :restrict_with_error
  has_many :project_attaches, dependent: :destroy

  accepts_attachments_for :project_attaches, attachment: :file, append: true
  accepts_nested_attributes_for :project_attaches, allow_destroy: true


  before_validation on: :create do
    self.status = STATUS_CREATED
  end

  validates :name, :status, :saldo, presence: true
  validates :price, :saldo, numericality: true



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

  def canceled?
    self.status == STATUS_CANCELED
  end

  def i18n_status
    STATUS_TYPES.find { |e| e[1] == self.status}[0]
  end

  def saldo
    incomes.sum(:amount) - expenses.sum(:amount)
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
