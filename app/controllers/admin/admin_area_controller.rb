class Admin::AdminAreaController < ApplicationController

         def login
                if request.post?
                         user = Administrator.authenticate(params[:username], params[:password])
                            if user
                                session[:administrator_id] = user.id
                                session[:administrator_name] = user.admin_name
                                #render :text=>session[:administrator_name].inspect and return false
                                flash[:notice] = "Log in successfully"
                                redirect_to "/admin/administrators"
                           elsif(params[:username].blank? && params[:password].blank?)
                                flash[:notice] = "Please enter username and password"
                                redirect_to "/admin/admin_area"
                           elsif(params[:username].blank?)
                                flash[:notice] = "Please enter username"
                                redirect_to "/admin/admin_area"
                           elsif(params[:password].blank?)
                                flash[:notice] = "Please enter password"
                                redirect_to "/admin/admin_area"
                         else
                                flash[:notice] = "Invalid username/password combination"
                                redirect_to "/admin/admin_area"
                             end
                   end

          end

          def logout
          end

          def index
                   @sessionid=session[:administrator_id]
          end

          def destroy
                  session[:administrator_id] = nil
                   flash[:notice] = "Logout successfully"
                   redirect_to "/admin/admin_area"
          end


end

