class HomeController < ApplicationController
  # 指定のactionにログイン無しでアクセスできるようにする
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index
    if current_user
      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      
      # current_tenantはcurrent_userのようなもの。multi-tier用の記述。
      @tenant = Tenant.current_tenant
      params[:tenant_id] = @tenant.id
    end
  end
end
