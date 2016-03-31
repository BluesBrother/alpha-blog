
class ArticlesController < ApplicationController

  # The following statement will invoke the find_article method BEFORE the specified actions begin. In each case (edit,
  # update, show, destroy) we must first fetch the article to be operated upon.

   before_action :find_article, only: [:show, :edit, :update, :destroy]

  # List all articles currently in database

  def index

    @articles = Article.all # Fetch all articles in the database

  end

  # When path articles/new is entered, the controller method "new" gets control. It creates a new Article object and assigns it to
  # the instance variable, @article. Then, by default, Rails will display a response view named, "new" (articles/new.html.erb).

  def new

    @article = Article.new # Create a new article and assign it to an instance variable, article

  end

  # When the user fills in the new article template and clicks Create Article, the controller method "create" receives
  # control (articles/create) with a hash called "params". The hash contains the input fields from the template, keyed
  # by field name (:title, :description). A new Article object is created and assigned to the instance variable @article.

  # The parameters used to initialize the new Article are extracted from the hash. Note that the parameters cannot be used
  # directly from the hash; first, they must be white-listed.

  # Finally, the new Article is saved to the database.

  # By default, when the create method exits, Ruby will attempt to render a view named, articles/create.html.erb, which
  # doesn't exist.

  def create

    #render plain: params[:article].inspect # Uncomment to display input parameters from web page

    #return # It is not an error to return early from a method

    @article = Article.new(article_params) # Create a new instance of Article initialized with values from the web form

    if @article.save # Save the new article to the database. Returns true if successful, false otherwise.
      flash[:notice] = 'New article was successfully created'
      # Re-direct to the show method to display the newly-created article. If we don't re-direct, Ruby will attempt to
      # return a response view based on the method name (create.html.erb).
      redirect_to article_path(@article) # article_path is a helper method; the "article" prefix is found by rake routes
    else # Article was not successfully saved
      render 'new' # Re-renders the New Article view (new.htlm.erb), but this time, error messages will be added
    end

  end

  # Display a given article by ID

  def show

  end

  # Edit an existing article by ID

  def edit

  end

  # When the user edits an existing article and clicks Update Article, the controller method "update" receives
  # control (articles/update) with a hash called "params". The hash contains the input fields from the template, keyed
  # by field name (:title, :description).

  # The parameters used to initialize the new Article are extracted from the hash. Note that the parameters cannot be used
  # directly from the hash; first, they must be white-listed.

  # Finally, the new Article is saved to the database.

  # By default, when the create method exits, Ruby will attempt to render a view named, articles/create.html.erb, which
  # doesn't exist.

  def update

    #render plain: params[:article].inspect # Uncomment to display input parameters from web page

    #return # It is not an error to return early from a method

    # We must specify the parameters to be updated (we don't want to update EVERY parameter. So we "whitelist" parameters
    # by explicitly selecting them for update.
    if @article.update(article_params) # Update the article in the database. Returns true if successful, false otherwise.
      flash[:notice] = 'Article was successfully updated'
      # Re-direct to the show method to display the updated article. If we don't re-direct, Ruby will attempt to
      # return a response view based on the method name (update.html.erb).
      redirect_to article_path(@article) # article_path is a helper method; the "article" prefix is found by rake routes
    else # Article was not successfully saved
      render 'edit' # Re-render the Edit view (edit.html.erb), but this time, error messages will be added
    end

  end

  # Delete an existing article

  def destroy

    @article.destroy # Remove the article from the database

    flash[:notice] = 'Article successfully deleted'

    redirect_to articles_path # Return to the listing of all Articles

  end

  # This is a private (local) method used to "white-list" the parameters in the hash so they can be extracted and used
  # as parameters to create a new Article.

  private # "private" introduces a section containing methods that are private to the class

  def find_article

    @article = Article.find(params[:id]) # Fetch the article by ID

  end

  # Whitelist article attributes title, description

  def article_params

    params.require(:article).permit(:title, :description)

  end



end