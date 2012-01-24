package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Comments.class)
public class Comments_ { 

    public static volatile SingularAttribute<Comments, Integer> commentid;
    public static volatile SingularAttribute<Comments, Short> commentstatus;
    public static volatile SingularAttribute<Comments, String> commentdescription;
    public static volatile SingularAttribute<Comments, Projects> projectid;

}