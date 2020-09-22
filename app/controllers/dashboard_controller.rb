class DashboardController < ApplicationController

  def index
    authorize! :read, :dashboard
    set_content_title('fa-fw fa fa-dashboard', ['Dashboard'])

    @caja_maxi = User.find_by_email('maximiliano@lapile.com.ar').caja
    @caja_javi = User.find_by_email('javier@lapile.com.ar').caja
    @caja_marcos = User.find_by_email('marcos@lapile.com.ar').caja
    @caja_mati = User.find_by_email('matias@lapile.com.ar').caja
    @caja_lapile = @caja_maxi + @caja_javi + @caja_marcos + @caja_mati
  end

  private

  # methods

end
