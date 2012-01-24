package seneca.projectManagement.entity;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Milestone.class)
public class Milestone_ { 

    public static volatile SingularAttribute<Milestone, String> milestonestatus;
    public static volatile SingularAttribute<Milestone, Integer> milestoneid;
    public static volatile SingularAttribute<Milestone, String> description;
    public static volatile SingularAttribute<Milestone, Date> duedate;
    public static volatile SingularAttribute<Milestone, Projects> projectid;

}