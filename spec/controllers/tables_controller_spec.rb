require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TablesController do

  # This should return the minimal set of attributes required to create a valid
  # Table. As you add validations to Table, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TablesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all tables as @tables" do
      raw_response_file = File.open("./spec/webmock/tables.json")
      stub_request(:get, ENV['tables']).
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      get :index
      assigns(:tables).should be_an_instance_of(TableCollection)
      assigns(:tables).tables.length.should equal(2)
      assigns(:tables).tables[0].origin_chamber.should eq('Senadores') # FIX we need to discuss about how to test the values in the response
    end
  end

  describe "GET show" do
    # [todo] - improve tests
    xit "assigns the requested table as @table" do
      table = Table.create! valid_attributes
      get :show, {:id => table.to_param}, valid_session
      assigns(:table).should eq(table)
    end
  end

  describe "GET new" do
    xit "assigns a new table as @table" do
      get :new, {}, valid_session
      assigns(:table).should be_a_new(Table)
    end
  end

  describe "GET edit" do
    xit "assigns the requested table as @table" do
      table = Table.create! valid_attributes
      get :edit, {:id => table.to_param}, valid_session
      assigns(:table).should eq(table)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      xit "creates a new Table" do
        expect {
          post :create, {:table => valid_attributes}, valid_session
        }.to change(Table, :count).by(1)
      end

      xit "assigns a newly created table as @table" do
        post :create, {:table => valid_attributes}, valid_session
        assigns(:table).should be_a(Table)
        assigns(:table).should be_persisted
      end

      xit "redirects to the created table" do
        post :create, {:table => valid_attributes}, valid_session
        response.should redirect_to(Table.last)
      end
    end

    describe "with invalid params" do
      xit "assigns a newly created but unsaved table as @table" do
        # Trigger the behavior that occurs when invalid params are submitted
        Table.any_instance.stub(:save).and_return(false)
        post :create, {:table => {  }}, valid_session
        assigns(:table).should be_a_new(Table)
      end

      xit "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Table.any_instance.stub(:save).and_return(false)
        post :create, {:table => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      xit "updates the requested table" do
        table = Table.create! valid_attributes
        # Assuming there are no other tables in the database, this
        # specifies that the Table created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Table.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => table.to_param, :table => { "these" => "params" }}, valid_session
      end

      xit "assigns the requested table as @table" do
        table = Table.create! valid_attributes
        put :update, {:id => table.to_param, :table => valid_attributes}, valid_session
        assigns(:table).should eq(table)
      end

      xit "redirects to the table" do
        table = Table.create! valid_attributes
        put :update, {:id => table.to_param, :table => valid_attributes}, valid_session
        response.should redirect_to(table)
      end
    end

    describe "with invalid params" do
      xit "assigns the table as @table" do
        table = Table.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Table.any_instance.stub(:save).and_return(false)
        put :update, {:id => table.to_param, :table => {  }}, valid_session
        assigns(:table).should eq(table)
      end

      xit "re-renders the 'edit' template" do
        table = Table.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Table.any_instance.stub(:save).and_return(false)
        put :update, {:id => table.to_param, :table => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    xit "destroys the requested table" do
      table = Table.create! valid_attributes
      expect {
        delete :destroy, {:id => table.to_param}, valid_session
      }.to change(Table, :count).by(-1)
    end

    xit "redirects to the tables list" do
      table = Table.create! valid_attributes
      delete :destroy, {:id => table.to_param}, valid_session
      response.should redirect_to(tables_url)
    end
  end

end
