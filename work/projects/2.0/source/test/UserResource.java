package test;

import java.util.*;
import javax.inject.*;
import kikaha.urouting.api.*;

@Path( "users" )
@Singleton
public class UserResource {

    @lombok.Getter
    final Map<Long, User> users = new HashMap<Long, User>();
  
    @GET
    public Collection<User> retrieveAllUsers(){
      return users.values();
    }

    @GET
    @Path( "{id}" )
    public User retrieveUserById(
            @PathParam( "id" ) long id ) {
        return users.get( id );
    }

    @POST
    public void persistUser( User user ) {
        users.put( user.getId(), user );
    }
}

