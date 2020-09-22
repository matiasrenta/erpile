class CashClosing < ActiveRecord::Base
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
  has_many :expenses, dependent: :nullify
  has_many :incomes, dependent: :nullify

  STATUS_CREATED   = 'CREATED'
  STATUS_CLOSED    = 'CLOSED'

  STATUS_TYPES = [['CREADA', STATUS_CREATED],
                  ['CERRADA', STATUS_CLOSED]]

  before_validation on: :create do
    self.status = STATUS_CREATED
  end

  before_validation :calculate

  validates :fecha_hora, :maxi_percent, :javi_percent, :marcos_percent, :mati_percent, :maxi_amount, :javi_amount, :marcos_amount, :mati_amount, :lapile_caja, :maxi_caja, :javi_caja, :marcos_caja, :mati_caja, :status, :user_id, presence: true
  validates :maxi_percent, :javi_percent, :marcos_percent, :mati_percent, :maxi_amount, :javi_amount, :marcos_amount, :mati_amount, :lapile_caja, :maxi_caja, :javi_caja, :marcos_caja, :mati_caja, :user_id, numericality: true


  after_save do
    # todo: logica para cambiar de estado todos los ingresos y gastos. recordar que luego las cajas de los usuarios no sumen estos ing/egre
    Expense.created.update_all(cash_closing_id: self.id)
    Income.created.update_all(cash_closing_id: self.id)
    if self.status == CashClosing::STATUS_CLOSED
      Expense.created.update_all(status: Expense::STATUS_ACCOUNTED)
      Income.created.update_all(status: Expense::STATUS_ACCOUNTED)
    end
  end

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

  private

  def calculate
    self.fecha_hora = Time.now

    self.maxi_caja = User.find_by_email('maximiliano@lapile.com.ar').caja
    self.javi_caja = User.find_by_email('javier@lapile.com.ar').caja
    self.marcos_caja =  User.find_by_email('marcos@lapile.com.ar').caja
    self.mati_caja = User.find_by_email('matias@lapile.com.ar').caja
    self.lapile_caja = self.maxi_caja + self.javi_caja + self.marcos_caja + self.mati_caja

    self.maxi_amount = (self.lapile_caja * self.maxi_percent) - self.maxi_caja
    self.javi_amount = (self.lapile_caja * self.javi_percent) - self.javi_caja
    self.marcos_amount = (self.lapile_caja * self.marcos_percent) - self.marcos_caja
    self.mati_amount = (self.lapile_caja * self.mati_percent) - self.mati_caja
  end

end
