package todoApp::Controller::Todos;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

todoApp::Controller::Todos - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched todoApp::Controller::Todos in Todos.');
}


sub get :Local {
	my ($self, $c)=@_;
	$c->stash(todos => [$c->model('DB::Todo')->all]);
}


 sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of book to delete
        my ($self, $c, $id) = @_;
    
        # Find the book object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
    
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "TODO $id not found!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

sub create :Local {
	my ($self, $c)=@_;
	if(!exists $c->request->parameters->{name}){
		return 	$c->stash(template => 'todos/create.tt');
	}
	my $name = $c->request->body_parameters->{name};
	my $comment = $c->request->body_parameters->{comment};
	my $todo = $c->model("DB::Todo")->create({
			name =>$name,
			comment => $comment,
		});
	$c->log->debug($c);
	$c->stash(todos => [$c->model('DB::Todo')->all], added => $todo, template=>"todos/get.tt");

}


sub delete :Chained('object') :PathPart('delete') :Args(0) {
        my ($self, $c) = @_;
    
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        $c->stash->{object}->delete;
    
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "TODO deleted.";
    
        # Forward to the list action/method in this controller
        $c->forward('get');
}


=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
