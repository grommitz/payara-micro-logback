package demo.rest.resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("test")
public class TestResource {
    private static final Logger LOG = LoggerFactory.getLogger(TestResource.class);

    @GET
    public String test() {
        LOG.info("called");
        return "success";
    }
}
