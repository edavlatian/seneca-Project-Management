package seneca.projectManagement.entity;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.3.0.v20110604-r9504", date="2012-02-21T14:02:11")
@StaticMetamodel(Milestone.class)
public class Milestone_ { 

    public static volatile SingularAttribute<Milestone, String> milestoneStatus;
    public static volatile SingularAttribute<Milestone, String> description;
    public static volatile SingularAttribute<Milestone, Integer> projectId;
    public static volatile SingularAttribute<Milestone, Date> dueDate;
    public static volatile SingularAttribute<Milestone, Integer> milestoneId;

}