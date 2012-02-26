package seneca.projectManagement.entity;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.3.0.v20110604-r9504", date="2012-02-23T14:35:25")
@StaticMetamodel(Projects.class)
public class Projects_ { 

    public static volatile SingularAttribute<Projects, String> prjConstraints;
    public static volatile SingularAttribute<Projects, Integer> instructorId;
    public static volatile SingularAttribute<Projects, Date> agreementDate;
    public static volatile SingularAttribute<Projects, String> status;
    public static volatile SingularAttribute<Projects, String> prjName;
    public static volatile SingularAttribute<Projects, String> description;
    public static volatile SingularAttribute<Projects, Integer> projectId;
    public static volatile SingularAttribute<Projects, Integer> companyId;
    public static volatile SingularAttribute<Projects, Integer> teamId;

}