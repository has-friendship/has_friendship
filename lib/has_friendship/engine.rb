module HasFriendship
  class Engine < ::Rails::Engine
    # Don't bother with isolate_namespace; we're only working with
    # one table here.
    #
    # isolate_namespace HasFriendship

    #
    # NOTE ABOUT DATABASE MIGRATIONS
    #
    # This Gem uses the `has_friendship:install:migrations` Rake task,
    # which is automatically provided by Rails::Engine. That Rake task
    # will copy the migration files from the Gem's db/migrate/
    # directory into the host app (with newly-generated timestamps).
    #
    # We use this `install:migrations` approach to provide developer
    # control. The application developer must be allowed to inspect
    # and modify the migration files (e.g. to change the foreign key
    # type from INTEGER to a UUID) before running `db:migrate`.
    #
    # Do not use the Rails Engine's `initializer :append_migrations`
    # feature in this Gem. Otherwise, the application developer would
    # loose that control.
    #

  end
end
