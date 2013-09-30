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


#REST api

sub create :Local {
	my ($self, $c)=@_;
	if(!exists $c->request->parameters->{name}){
		return 	$c->stash(template => 'todos/create.tt');
	}
	my $name = $c->request->body_parameters->{name};
	my $comment = $c->request->body_parameters->{comment};
	my $todo = $c->model("DB::Todo")->create({
			name =>"tewt1",
			comment => "tesfcom",
		});
	$c->log->debug($c);
	$c->stash(todos => [$c->model('DB::Todo')->all], added => $todo);

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
