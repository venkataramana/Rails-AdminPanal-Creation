class Admin::AdministratorsController < ApplicationController
        before_filter :loggedin, :only => [:index, :show, :edit, :update, :destroy]
        def index
               # logger.info 'informational message'
                if !params[:per_page].nil? && !params[:per_page].blank?
                         if params[:per_page] != "all"
                                @limit= params[:per_page].to_i
                        end
                else
                        @limit = 20
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
                        @option="admin_name"
                end

                if session[:administrator_id]

                  @administrators = Admin::Administrator.paginate :page => params[:page], :per_page =>@limit, :conditions => ["#{@option} LIKE ?","#{params[:search]}%"], :order=>"administrators.#{sort} #{sorten}"
                        #render :text=>@administrators.count().inspect and return false
                else
                      redirect_to "/admin/admin_area"
                end

        end
        def new
                @administrator=Admin::Administrator.new
        end
        def create
                #render :text => params.inspect and return false
                @administrator=Admin::Administrator.new(params[:administrator])
                if @administrator.save

                        redirect_to "/admin/administrators"
                else
                        render :action=> "new"
                end
        end
        def edit
               @administrator=Admin::Administrator.find(params[:id])
               #render :text=> @administrator.inspect and return false
        end
        def update
                @administrator=Admin::Administrator.find(params[:id])
                @administrator.update_attributes(params[:administrator])
                redirect_to "/admin/administrators"
        end
        def destroy
               @administrator=Admin::Administrator.find(params[:id])
                @administrator.destroy
                flash[:notice]="1 administrator deleted success fully"
                redirect_to "/admin/administrators"
        end
        def list_action
		id_string = params[:chk].join(',') if !params[:chk].nil?
		condition_string = " id in (#{id_string})";
		effectedRows = params[:chk].length if !params[:chk].nil?;
		case  params[:make_action]
                        when  "active"
                                flash[:notice]="No activation"
                                redirect_to :controller=>'administrators'
                        when  "inactive"
                                flash[:notice]="No deactivation"
                                redirect_to :controller=>'administrators'
			when    "delete"
				Admin::Administrator.delete_all(condition_string)
				flash[:notice]="#{effectedRows} Administrator(s) deleted successfully."
				redirect_to :controller=>'administrators'
		end
	end

        def loggedin
                redirect_to "/admin/admin_area" if session[:administrator_id].nil?
        end
end

