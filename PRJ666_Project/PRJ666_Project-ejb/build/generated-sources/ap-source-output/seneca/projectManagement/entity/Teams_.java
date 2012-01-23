package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;
import seneca.projectManagement.entity.Teammember;
import seneca.projectManagement.entity.Teamprojectranking;
import seneca.projectManagement.entity.Users;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T16:07:53")
@StaticMetamodel(Teams.class)
public class Teams_ { 

    public static volatile SingularAttribute<Teams, Short> hasregistered;
    public static volatile SingularAttribute<Teams, Integer> teamid;
    public static volatile SingularAttribute<Teams, Short> teamstatus;
    public static volatile SingularAttribute<Teams, String> teamname;
    public static volatile CollectionAttribute<Teams, Teammember> teammemberCollection;
    public static volatile CollectionAttribute<Teams, Projects> projectsCollection;
    public static volatile SingularAttribute<Teams, String> teamemail;
    public static volatile SingularAttribute<Teams, Users> userid;
    public static volatile SingularAttribute<Teams, Projects> projectid;
    public static volatile CollectionAttribute<Teams, Teamprojectranking> teamprojectrankingCollection;
    public static volatile SingularAttribute<Teams, String> teamidentifier;
    public static volatile SingularAttribute<Teams, String> teamconstraints;

}