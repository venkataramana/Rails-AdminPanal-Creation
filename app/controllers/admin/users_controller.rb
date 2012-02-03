class Admin::UsersController < ApplicationController
        def index
                 if !params[:per_page].nil? && !params[:per_page].blank?
                         if params[:per_page] != "all"
                                @limit= params[:per_page].to_i
                        end
                else
                        @limit = 6
                end
                 if !params[:sort].nil?
                      sort = params[:sort]
                else
                        sort = "id"
                end

                if !params[:sorten].nil?
                        sorten = params[:sorten]
                        if params[:sorten] == "Asc"
                                @sorten_list = "Desc"
                        else
                                @sorten_list = "Asc"
                        end
                else
                        sorten = "Asc"
                        @sorten_list = "Desc"
                end

                if !params[:option].nil? && !params[:option].blank?
                        @option= params[:option].to_s
                else
                        @option="name"
                end

                 if session[:administrator_id]
                        @users = User.paginate :page => params[:page], :per_page => @limit, :conditions => ["#{@option} LIKE ?","#{params[:search]}%"], :order=>"users.#{sort} #{sorten}"
                else
                      redirect_to "/admin/admin_area"
                 end
        end

        def new
                 if session[:administrator_id]
                        @user = User.new
                else
                      redirect_to "/admin/admin_area"
                end
        end
        def create
                if session[:administrator_id]
                        @user = User.new(params[:user])
                        if @user.save
                                redirect_to "/admin/users"
                        else
                                render :action => "new"
                        end
                else
                        redirect_to "/admin/admin_area"
                end

        end
        def edit
               @user=Admin::User.find(params[:id])
               #render :text=> @administrator.inspect and return false
        end
        def update
                @user=Admin::User.find(params[:id])
                @user.update_attributes(params[:user])
                redirect_to "/admin/users"
        end
        def destroy
               @user=Admin::User.find(params[:id])
                @user.destroy
                redirect_to "/admin/users"
        end
        def list_action
		id_string = params[:chk].join(',') if !params[:chk].nil?
		condition_string = " id in (#{id_string})";
		effectedRows = params[:chk].length if !params[:chk].nil?;
		case  params[:make_action]
		        when  "active"
                                flash[:notice]="No activation"
                                redirect_to :controller=>'users'
                        when  "inactive"
                                flash[:notice]="No deactivation"
                                redirect_to :controller=>'users'
			when    "delete"
				#~ Sitemanager::Restaurant.update_all("status='Inactive', member_id = 0" , "member_id in (#{id_string})") if Cpanel::Restaurant.exists?(["member_id in (#{id_string})"])
				Admin::User.delete_all(condition_string)
				flash[:notice]="#{effectedRows} user(s) deleted successfully."
				redirect_to :controller=>'users'
		end
	end
end

