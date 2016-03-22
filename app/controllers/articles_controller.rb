
class ArticlesController < ApplicationController

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
      render 'new' # Simply re-renders the same view, but this time, error messages will be added
    end

  end

  # Display a given article by ID

  def show

    @article = Article.find(params[:id]) # Fetch the article by ID

  end

  # This is a private (local) method used to "white-list" the parameters in the hash so they can be extracted and used
  # as parameters to create a new Article.

  private
  def article_params

    params.require(:article).permit(:title, :description)

  end



end