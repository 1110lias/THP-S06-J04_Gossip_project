class GossipsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_creator, only: [:edit, :update, :destroy]

  def index
    puts "here first"
    @gossips = Gossip.all
    puts "here!"
  end
  
  def show
    @gossip = Gossip.find(params[:id])
    @comments = Comment.where(gossip_id: @gossip.id)
  end
  
  def new
    @gossip = Gossip.new
  end
  
  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user_id = session[:user_id]
    if @gossip.save
      redirect_to gossips_path, notice: 'Gossip créé avec succès!'
      flash[:success] = "C'EST UN SUCCES!BRAVO!" #pour afficher le bandeau alerte (Voir html new)
    else
      render :new
      flash[:danger] = "C'EST FOIRE" #pour afficher le bandeau alerte (Voir html index)
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    
    if @gossip.update(gossip_params)
      redirect_to gossips_path, notice: 'Gossip modifié avec succès!'
      flash[:success] = "C'EST UN SUCCES!BRAVO!" #pour afficher le bandeau alerte (Voir html new)
    else
      render :edit
      flash[:danger] = "C'EST FOIRE" #pour afficher le bandeau alerte (Voir html index)
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path
  end

  private
  
  def gossip_params
    params.require(:gossip).permit(:title, :description)
  end
end
