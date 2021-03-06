package edu.emory.abid;

import javax.ws.rs.ApplicationPath;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.jackson.JacksonFeature;

@ApplicationPath("resources")
public class JerseyRestApplication extends ResourceConfig {
    public JerseyRestApplication() {
         packages("edu.emory.abid");
         register(JacksonFeature.class);
         register(JerseyMapperProvider.class);
    }
}