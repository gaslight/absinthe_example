defmodule Blog.Schema do
  use Absinthe.Schema

  alias Blog.Resolver

  import_types Blog.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &Resolver.Post.all/2
    end
    field :user, :user do
      arg :id, non_null(:id)

      resolve &Resolver.User.find/2
    end
    field :users, list_of(:user) do
      resolve &Resolver.User.all/2
    end

    field :customers, list_of(:customer) do
      resolve &Resolver.Customer.all/2
    end

    field :customer, :customer do
      arg :id, non_null(:id)

      resolve &Resolver.Customer.find/2
    end
  end

  mutation do
    field :create_post, :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)

      resolve &Resolver.Post.create/2
    end

    field :create_customer, :customer do
      arg :customer_attributes, :customer_input
      resolve &Resolver.Customer.create/2
    end

    field :update_customer, :customer do
      arg :id, non_null(:id)
      arg :customer_attributes, :customer_input
      resolve &Resolver.Customer.update/2
    end

    field :create_user, :user do
      arg :name, non_null(:string)
      resolve &Resolver.User.create/2
    end
  end
end
