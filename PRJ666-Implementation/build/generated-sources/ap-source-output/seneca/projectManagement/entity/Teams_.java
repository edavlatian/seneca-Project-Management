package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.3.0.v20110604-r9504", date="2012-02-27T10:16:18")
@StaticMetamodel(Teams.class)
public class Teams_ { 

    public static volatile SingularAttribute<Teams, String> teamName;
    public static volatile SingularAttribute<Teams, String> teamDescription;
    public static volatile SingularAttribute<Teams, Integer> hasRegistered;
    public static volatile SingularAttribute<Teams, String> teamEmail;
    public static volatile SingularAttribute<Teams, String> teamLogo;
    public static volatile SingularAttribute<Teams, Integer> userId;
    public static volatile SingularAttribute<Teams, Integer> teamStatus;
    public static volatile SingularAttribute<Teams, Integer> projectId;
    public static volatile SingularAttribute<Teams, String> teamConstraints;
    public static volatile SingularAttribute<Teams, Integer> teamId;

}