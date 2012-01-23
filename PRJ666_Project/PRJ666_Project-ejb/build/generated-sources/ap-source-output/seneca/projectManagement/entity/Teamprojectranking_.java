package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;
import seneca.projectManagement.entity.TeamprojectrankingPK;
import seneca.projectManagement.entity.Teams;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T16:07:53")
@StaticMetamodel(Teamprojectranking.class)
public class Teamprojectranking_ { 

    public static volatile SingularAttribute<Teamprojectranking, Teams> teams;
    public static volatile SingularAttribute<Teamprojectranking, Projects> projects;
    public static volatile SingularAttribute<Teamprojectranking, TeamprojectrankingPK> teamprojectrankingPK;
    public static volatile SingularAttribute<Teamprojectranking, Short> ranking;

}