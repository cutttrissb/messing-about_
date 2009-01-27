class ProductArchivesController < ApplicationController
  # GET /product_archives
  # GET /product_archives.xml
  def index
    @product_archives = ProductArchive.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_archives }
    end
  end

  # GET /product_archives/1
  # GET /product_archives/1.xml
  def show
    @product_archive = ProductArchive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_archive }
    end
  end

  # GET /product_archives/new
  # GET /product_archives/new.xml
  def new
    @product_archive = ProductArchive.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_archive }
    end
  end

  # GET /product_archives/1/edit
  def edit
    @product_archive = ProductArchive.find(params[:id])
  end

  # POST /product_archives
  # POST /product_archives.xml
  def create
    @product_archive = ProductArchive.new(params[:product_archive])

    respond_to do |format|
      if @product_archive.save
        flash[:notice] = 'ProductArchive was successfully created.'
        format.html { redirect_to(@product_archive) }
        format.xml  { render :xml => @product_archive, :status => :created, :location => @product_archive }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_archive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_archives/1
  # PUT /product_archives/1.xml
  def update
    @product_archive = ProductArchive.find(params[:id])

    respond_to do |format|
      if @product_archive.update_attributes(params[:product_archive])
        flash[:notice] = 'ProductArchive was successfully updated.'
        format.html { redirect_to(@product_archive) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_archive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_archives/1
  # DELETE /product_archives/1.xml
  def destroy
    @product_archive = ProductArchive.find(params[:id])
    @product_archive.destroy

    respond_to do |format|
      format.html { redirect_to(product_archives_url) }
      format.xml  { head :ok }
    end
  end
end
