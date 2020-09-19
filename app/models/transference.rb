class Transference < ActiveRecord::Base
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


  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  STATUS_CREATED      = 'CREATED'
  STATUS_ACCEPTED    = 'ACCEPTED'

  STATUS_TYPES = [['CREADA', STATUS_CREATED],
                  ['ACEPTADA', STATUS_ACCEPTED]]

  before_validation on: :create do
    self.status = STATUS_CREATED
  end

  validates :concept, :from_user_id, :to_user_id, :amount, :status, presence: true
  validates :from_user_id, :to_user_id, :amount, numericality: true

  after_save on: :update do
    if self.status == STATUS_ACCEPTED
      Expense.create(concept: "TRANSFERENCIA - #{self.concept}", amount: self.amount, fecha: self.created_at, user_id: self.from_user_id, status: Expense::STATUS_CREATED)
      Income.create(concept: "TRANSFERENCIA - #{self.concept}", amount: self.amount, fecha: self.created_at, user_id: self.to_user_id, status: Income::STATUS_CREATED)
    end
  end



  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
