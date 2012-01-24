package seneca.projectManagement.entity;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Comments;
import seneca.projectManagement.entity.Company;
import seneca.projectManagement.entity.Milestone;
import seneca.projectManagement.entity.Projectfile;
import seneca.projectManagement.entity.Teamprojectranking;
import seneca.projectManagement.entity.Teams;
import seneca.projectManagement.entity.Users;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Projects.class)
public class Projects_ { 

    public static volatile CollectionAttribute<Projects, Milestone> milestoneCollection;
    public static volatile CollectionAttribute<Projects, Teams> teamsCollection;
    public static volatile SingularAttribute<Projects, Teams> teamid;
    public static volatile SingularAttribute<Projects, Users> instructorid;
    public static volatile SingularAttribute<Projects, String> status;
    public static volatile SingularAttribute<Projects, String> prjname;
    public static volatile CollectionAttribute<Projects, Comments> commentsCollection;
    public static volatile SingularAttribute<Projects, Company> companyid;
    public static volatile SingularAttribute<Projects, String> prjconstraints;
    public static volatile SingularAttribute<Projects, String> description;
    public static volatile SingularAttribute<Projects, Date> agreementdate;
    public static volatile SingularAttribute<Projects, String> prjidentifier;
    public static volatile CollectionAttribute<Projects, Teamprojectranking> teamprojectrankingCollection;
    public static volatile SingularAttribute<Projects, Integer> projectid;
    public static volatile CollectionAttribute<Projects, Projectfile> projectfileCollection;

}