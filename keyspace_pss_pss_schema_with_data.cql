CREATE KEYSPACE keyspace_pss_pss WITH REPLICATION = { 'class' : 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '1' } AND DURABLE_WRITES = true;

CREATE TABLE keyspace_pss_pss.application (
    name text,
    anaisappkeyocean text,
    anaisappkeyprisme text,
    description text,
    externalconfig text,
    externalscope text,
    internalmapping text,
    interopsconfig text,
    oceanconfig text,
    password_app text,
    serviceuri text,
    type text,
    userpkcs12 text,
    PRIMARY KEY (name)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;

CREATE INDEX application_serviceuri_idx ON keyspace_pss_pss.application (serviceuri);

CREATE TABLE keyspace_pss_pss.police (
    id text,
    datajson text,
    dataxacml text,
    PRIMARY KEY (id)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;
CREATE TABLE keyspace_pss_pss.police (
    id text,
    datajson text,
    dataxacml text,
    PRIMARY KEY (id)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;CREATE TABLE keyspace_pss_pss.application (
    name text,
    anaisappkeyocean text,
    anaisappkeyprisme text,
    description text,
    externalconfig text,
    externalscope text,
    internalmapping text,
    interopsconfig text,
    oceanconfig text,
    password_app text,
    serviceuri text,
    type text,
    userpkcs12 text,
    PRIMARY KEY (name)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;

CREATE INDEX application_serviceuri_idx ON keyspace_pss_pss.application (serviceuri);-----------------------------------------------------------DATA--------------------------------------------------------CREATE TABLE keyspace_pss_pss.police (
    id text,
    datajson text,
    dataxacml text,
    PRIMARY KEY (id)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_SNV2-GDC-BE_v1.0.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour SNV2-GDC-BE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-GDC-BE</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_SNV2-GDC-BE_ACCES_CONSULTATION">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-GDC-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:SNV2-GDC-BE:ACCES_CONSULTATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_GCE-BE_COMMON">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getAllCodificationsUsingGET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getCodesByCodificationIdUsingGET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getHealth</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_GCE-BE_OBDE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjd</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjdMvts</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjdMvt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getHealth</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_SNV2-GDC-BE_ACCES_CONSULTATION"/>
</Policy>
','SNV2-GDC-BE','{"allow":[{"result":[{"values":["DEFAULT:SNV2-GDC-BE:ACCES_CONSULTATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["SNV2-GDC-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_SNV2-GDC-BE_ACCES_CONSULTATION"},{"match":[{"values":["GCECommon_getAllCodificationsUsingGET","GCECommon_getCodesByCodificationIdUsingGET","GCECommon_getHealth"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_GCE-BE_COMMON"},{"match":[{"values":["OBDE_getPjd","OBDE_getPjdMvts","OBDE_getPjdMvt","OBDE_getHealth"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_GCE-BE_OBDE"}],"deny":[{"id":"deny_for_SNV2-GDC-BE_ACCES_CONSULTATION"}],"description":"Policy pour SNV2-GDC-BE","id":"Policy_SNV2-GDC-BE_v1.0.0","target":[{"values":["SNV2-GDC-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["GCECommon_*","OBDE_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_interco_token_test_v1.1.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy interco pour generation Token</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ConsultationCompte</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">EnregistrerMandat</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchDemoNewChamp</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_from_WEBAE-BDS_CCT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PortAnnabelProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">.*</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:subject" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:BEAE:BEAE_ACCES_WEB</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:scope" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:scope">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">*:OPUS-BE</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_from_DECLTI_EMT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">InteropsProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">CONSULTATION-RAAM-TI</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:pagm" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:BEAE:BEAE_LIRE_DECLTI</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:BEAE:BEAE_ACCES_DECLTI</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:subject" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:subject">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">UR83794001</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:scope" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:scope">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">*:OPUS-BE</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:client-id" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:client-id">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">cn=USR_READ_NAT_APP_IODA-BE,ou=IODA-BE,ou=Applications,ou=Technique,dc=recouv</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:custom" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:custom">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">custom_field=ceci est mon custom Field</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_from_ARCHDEMO_NEW_CHAMP">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchDemoNewChamp</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">97df09ae-87f7-4189-9c39-b5cac99b9d51</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:organization:id" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Recouv Consommateurs</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:organization:name" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">aa30b15f-9ec6-49af-85e0-aa41f139e25d</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:application:id" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHDEMO-DMZ-MIG</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:application:name" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHDEMO:AUTH_BACK</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
</Policy>
','INTERCO','{"allow":[{"result":[{"values":["DEFAULT:BEAE:BEAE_ACCES_WEB"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"},{"values":["*:OPUS-BE"],"type":"SCOPE_REQ_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["PortAnnabelProvider"],"type":"EXT_PROVIDER_SUBJECT"},{"values":[".*"],"type":"EXT_LOGIN_SUBJECT"}],"id":"permit_from_WEBAE-BDS_CCT"},{"result":[{"values":["DEFAULT:BEAE:BEAE_LIRE_DECLTI","DEFAULT:BEAE:BEAE_ACCES_DECLTI"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"},{"values":["UR83794001"],"type":"result_subject"},{"values":["*:OPUS-BE"],"type":"SCOPE_REQ_AT_JWT_CLAIM_RESULT_ATTRB"},{"values":["cn=USR_READ_NAT_APP_IODA-BE,ou=IODA-BE,ou=Applications,ou=Technique,dc=recouv"],"type":"AUD_JWT_CLAIM_RESULT_ATTRB"},{"values":["custom_field=ceci est mon custom Field"],"type":"CUSTOM_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["InteropsProvider"],"type":"EXT_PROVIDER_SUBJECT"},{"values":["CONSULTATION-RAAM-TI"],"type":"EXT_PAGM_SUBJECT"}],"id":"permit_from_DECLTI_EMT"},{"result":[{"values":["DEFAULT:ARCHDEMO:AUTH_BACK"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ArchDemoNewChamp"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["97df09ae-87f7-4189-9c39-b5cac99b9d51"],"type":"EXT_ORGANIZATION_ID"},{"values":["Recouv Consommateurs"],"type":"EXT_ORGANIZATION_NAME"},{"values":["aa30b15f-9ec6-49af-85e0-aa41f139e25d"],"type":"EXT_APPLICATION_ID"},{"values":["ARCHDEMO-DMZ-MIG"],"type":"EXT_APPLICATION_NAME"}],"id":"permit_from_ARCHDEMO_NEW_CHAMP"}],"description":"Policy interco pour generation Token","id":"Policy_interco_token_test_v1.1.0","target":[{"values":["ConsultationCompte","EnregistrerMandat","ArchDemoNewChamp"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_PRISME-PSS_v1.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour PRISME-PSS</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_Steering_PASSTECH">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/backend/config/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/backend/services/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/backend/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/comptestechniques/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/dashboard/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/frontend/config/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/frontend/ext/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/frontend/int/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/frontend/list/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/frontend/user/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/granttype/ext</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/granttype/int</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/keys/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/ocean/list</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/providers/ext/list</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/providers/int/list</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/scopes/ext</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/scopes/int</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/version/</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v2/backend/config</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/precheck/config</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/check/config</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/upload/config</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/upload/interops</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/check/policy</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/upload/policy</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/security/steering/v1/get/policy</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION_COMPTE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PRISME-PSS:NAT_ADMINISTRATION_HP</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_PRISME-PSS"/>
</Policy>
','PRISME-PSS','{"allow":[{"result":[{"values":["DEFAULT:PRISME-PSS:NAT_ADMINISTRATION_HP"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["\/security\/steering\/v1\/backend\/config\/","\/security\/steering\/v1\/backend\/services\/","\/security\/steering\/v1\/backend\/","\/security\/steering\/v1\/comptestechniques\/","\/security\/steering\/v1\/dashboard\/","\/security\/steering\/v1\/frontend\/config\/","\/security\/steering\/v1\/frontend\/ext\/","\/security\/steering\/v1\/frontend\/int\/","\/security\/steering\/v1\/frontend\/list\/","\/security\/steering\/v1\/frontend\/user\/","\/security\/steering\/v1\/granttype\/ext","\/security\/steering\/v1\/granttype\/int","\/security\/steering\/v1\/keys\/","\/security\/steering\/v1\/ocean\/list","\/security\/steering\/v1\/providers\/ext\/list","\/security\/steering\/v1\/providers\/int\/list","\/security\/steering\/v1\/scopes\/ext","\/security\/steering\/v1\/scopes\/int","\/security\/steering\/v1\/version\/","\/security\/steering\/v2\/backend\/config","\/security\/steering\/v1\/precheck\/config","\/security\/steering\/v1\/check\/config","\/security\/steering\/v1\/upload\/config","\/security\/steering\/v1\/upload\/interops","\/security\/steering\/v1\/check\/policy","\/security\/steering\/v1\/upload\/policy","\/security\/steering\/v1\/get\/policy"],"type":"URL_REGEX_RESOURCE_TYPE"},{"values":["PASSTECH:CONSULTATION","PASSTECH:CONSULTATION_COMPTE","PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_Steering_PASSTECH"}],"deny":[{"id":"deny_for_PRISME-PSS"}],"description":"Policy pour PRISME-PSS","id":"Policy_PRISME-PSS_v1.0","target":[{"values":["\/security\/steering\/*"],"type":"URL_REGEX_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="INTERCO-DFE" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour AMME-MIG-DFE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/dfe/interco</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">.*</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:subject" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PortAnnabelProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit2">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">InteropsProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">CONSULTATION-RAAM-TI2|CONSULTATION-RAAM-TI</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:pagm" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit3">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedDMZProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
</Policy>
','INTERCO-DFE','{"allow":[{"match":[{"values":["GET"],"type":"match_method"},{"values":[".*"],"type":"match_front_ext_subject"},{"values":["PortAnnabelProvider"],"type":"match_front_ext_provider"}],"id":"permit"},{"result":[{"values":["DEFAULT:BEAE:BEAE_ACCES_DECLTI"],"type":"authorization_back"}],"match":[{"values":["GET","POST"],"type":"match_method"},{"values":["InteropsProvider"],"type":"match_front_ext_provider"},{"values":["CONSULTATION-RAAM-TI2|CONSULTATION-RAAM-TI"],"type":"match_front_ext_pagm"}],"id":"permit2"},{"result":[{"values":["DEFAULT:BEAE:BEAE_ACCES_DECLTI"],"type":"authorization_back"}],"match":[{"values":["GET","POST"],"type":"match_method"},{"values":["ArchimedDMZProvider"],"type":"match_front_ext_provider"}],"id":"permit3"}],"description":"Policy pour AMME-MIG-DFE","id":"INTERCO-DFE","target":[{"values":["\/dfe\/interco"],"type":"match_path_equals"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_SNV2-GCE-BE_v1.0.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour SNV2-GCE-BE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-GCE-BE</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_SNV2-GCE-BE_ACCES_CONSULTATION">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-GCE-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:SNV2-GCE-BE:ACCES_CONSULTATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_GCE-BE_COMMON">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getAllCodificationsUsingGET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getCodesByCodificationIdUsingGET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GCECommon_getHealth</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_GCE-BE_OBDE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjd</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjdMvts</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getPjdMvt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OBDE_getHealth</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:VERIFICATION_COMPTABLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:COMPTABILITE_EXPERT_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:TELECONSEIL_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:CONTROLE_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_1</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ISURSI_MIXTE_2</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ESB_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_CONTROLE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_SNV2-GCE-BE_ACCES_CONSULTATION"/>
</Policy>
','SNV2-GCE-BE','{"allow":[{"result":[{"values":["DEFAULT:SNV2-GCE-BE:ACCES_CONSULTATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["SNV2-GCE-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_SNV2-GCE-BE_ACCES_CONSULTATION"},{"match":[{"values":["GCECommon_getAllCodificationsUsingGET","GCECommon_getCodesByCodificationIdUsingGET","GCECommon_getHealth"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_GCE-BE_COMMON"},{"match":[{"values":["OBDE_getPjd","OBDE_getPjdMvts","OBDE_getPjdMvt","OBDE_getHealth"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N1","SNV2-PROD:ASSISTANCE_FONCTIONNELLE_N2","SNV2-PROD:COMPTABILITE_N1","SNV2-PROD:VERIFICATION_COMPTABLE_N2","SNV2-PROD:COMPTABILITE_EXPERT_N3","SNV2-PROD:CONSULTATION","SNV2-PROD:TELECONSEIL_N1","SNV2-PROD:CONTROLE_N1","SNV2-PROD:CONTROLE_N2","SNV2-PROD:CONTROLE_N3","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N1","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N2","SNV2-PROD:GESTION_ADMINISTRATIVE_DES_COMPTES_N3","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES","SNV2-PROD:GESTION_JURIDIQUE_DES_COMPTES_N2","SNV2-PROD:GESTIONNAIRE_ECHEANCES_MUTUALISE","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N1","SNV2-PROD:PLANIFICATION_OU_PARAMETRAGE_V2_N2","SNV2-PROD:ISURSI_MIXTE_1","SNV2-PROD:ISURSI_MIXTE_2","SNV2-PROD:ESB_TECH","SNV2-PROD:ASSISTANCE_CONTROLE","SNV2-PROD:ASSISTANCE_NATIONALE","SNV2-PROD:ASSISTANCE_NATIONALE_CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_GCE-BE_OBDE"}],"deny":[{"id":"deny_for_SNV2-GCE-BE_ACCES_CONSULTATION"}],"description":"Policy pour SNV2-GCE-BE","id":"Policy_SNV2-GCE-BE_v1.0.0","target":[{"values":["SNV2-GCE-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["GCECommon_*","OBDE_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_ARCHIMED-SAMPLE_v1.0.3" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour ARCHIMED-SAMPLE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-SAMPLE</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchdemoDist_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-SAMPLE_CONSULTATION_SERVICE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-SAMPLE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:NAT_UTILISATEUR</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-SAMPLE:CONSULTATION_SERVICE</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-SAMPLE_1">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchdemoDist_Calorie</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:NAT_UTILISATEUR</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_ARCHIMED-SAMPLE"/>
</Policy>
','ARCHIMED-SAMPLE','{"allow":[{"result":[{"values":["DEFAULT:ARCHIMED-SAMPLE:CONSULTATION_SERVICE"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-SAMPLE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:NAT_UTILISATEUR"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-SAMPLE_CONSULTATION_SERVICE"},{"match":[{"values":["ArchdemoDist_Calorie"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:NAT_UTILISATEUR"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-SAMPLE_1"}],"deny":[{"id":"deny_for_ARCHIMED-SAMPLE"}],"description":"Policy pour ARCHIMED-SAMPLE","id":"Policy_ARCHIMED-SAMPLE_v1.0.3","target":[{"values":["ARCHIMED-SAMPLE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ArchdemoDist_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_ARCHIMED-CLOUD-BE_v1.3" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour ARCHIMED-CLOUD-BE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-CLOUD-BE</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-CLOUD-FE-DMZ">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetCalories</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchDemoProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">.*</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:subject" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-CLOUD-FE-DMZ-MIG</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:application:name" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-CLOUD-FE-DMZ</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:application:name" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-CLOUD-BE:ACCES_CONSULTATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-CLOUD-BE_ACCES_CONSULTATION">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-CLOUD-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-CLOUD-BE:ACCES_CONSULTATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-CLOUD-BE_1">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_GetCalories</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-CLOUD-BE_2">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_PutFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-CLOUD-BE_3">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedCloud_DeleteFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCL:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_ARCHIMED-SAMPLE"/>
</Policy>
','ARCHIMED-CLOUD-BE','{"allow":[{"result":[{"values":["DEFAULT:ARCHIMED-CLOUD-BE:ACCES_CONSULTATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ArchimedCloud_GetFruits","ArchimedCloud_GetFruit","ArchimedCloud_GetCalories"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ArchDemoProvider"],"type":"EXT_PROVIDER_SUBJECT"},{"values":[".*"],"type":"EXT_LOGIN_SUBJECT"},{"values":["ARCHIMED-CLOUD-FE-DMZ-MIG","ARCHIMED-CLOUD-FE-DMZ"],"type":"EXT_APPLICATION_NAME"}],"id":"permit_for_ARCHIMED-CLOUD-FE-DMZ"},{"result":[{"values":["DEFAULT:ARCHIMED-CLOUD-BE:ACCES_CONSULTATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-CLOUD-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-CLOUD-BE_ACCES_CONSULTATION"},{"match":[{"values":["ArchimedCloud_GetFruits","ArchimedCloud_GetFruit","ArchimedCloud_GetCalories"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-CLOUD-BE_1"},{"match":[{"values":["ArchimedCloud_PutFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-CLOUD-BE_2"},{"match":[{"values":["ArchimedCloud_DeleteFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH","ARCL:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-CLOUD-BE_3"}],"deny":[{"id":"deny_for_ARCHIMED-SAMPLE"}],"description":"Policy pour ARCHIMED-CLOUD-BE","id":"Policy_ARCHIMED-CLOUD-BE_v1.3","target":[{"values":["ARCHIMED-CLOUD-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ArchimedCloud_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Police_ARCHIMED-BAPI_INTRA_ALL_v1.0.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour ARCHIMED-BAPI_INTRA_ALL</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_TECH_INTRA">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_COMPTES_BANCAIRES_INTRA">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_NAT_INTRA">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_NAT</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_TECH_GET">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Maps</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Ancre</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_MtomDownload</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_ListerBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_LancerBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_RecupererBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_KPS</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Mtom</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Throttle</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SOAP</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetCalories</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruitRestToSoap</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruitRestToSoapVm</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxInfobase</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxGetAnimaux</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_TECH_POST">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Recaptcha</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_MtomUpload</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxPostAnimaux</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_TECH_PUT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PutFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_TECH_DELETE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_DeleteFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_COMPTES_BANCAIRES_GET">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetClient</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetCompteAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Operations</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_COMPTES_BANCAIRES_POST">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PostClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PostCompteAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Virement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_COMPTES_BANCAIRES_DELETE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_DeleteClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="Rule_for_CONSULTATION_COMPTES_BANCAIRES_PUT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PutClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
</Policy>
','BAPI-INTRA-ALL','{"allow":[{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_TECH_INTRA"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_COMPTES_BANCAIRES_INTRA"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_NAT"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_NAT_INTRA"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_Maps","Archdemo_Ancre","Archdemo_MtomDownload","Archdemo_ListerBatch","Archdemo_LancerBatch","Archdemo_RecupererBatch","Archdemo_KPS","Archdemo_Mtom","Archdemo_GetFruits","Archdemo_GetFruit","Archdemo_Throttle","Archdemo_SOAP","Archdemo_GetCalories","Archdemo_GetFruitRestToSoap","Archdemo_GetFruitRestToSoapVm","Archdemo_SxInfobase","Archdemo_SxFruits","Archdemo_SxGetAnimaux"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_TECH_GET"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_Recaptcha","Archdemo_MtomUpload","Archdemo_SxPostAnimaux"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_TECH_POST"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_PutFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_TECH_PUT"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_DeleteFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_TECH_DELETE"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_GetClient","Archdemo_GetClientAnais","Archdemo_GetCompteAnais","Archdemo_Operations"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_COMPTES_BANCAIRES_GET"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_PostClientAnais","Archdemo_PostCompteAnais","Archdemo_Virement"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_COMPTES_BANCAIRES_POST"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_DeleteClientAnais"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_COMPTES_BANCAIRES_DELETE"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["Archdemo_PutClientAnais"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"Rule_for_CONSULTATION_COMPTES_BANCAIRES_PUT"}],"description":"Policy pour ARCHIMED-BAPI_INTRA_ALL","id":"Police_ARCHIMED-BAPI_INTRA_ALL_v1.0.0","target":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["Archdemo_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_ARCHIMED-BAPI_v1.0" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour ARCHIMED-BAPI</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_CONSULTATION_TECH">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_CONSULTATION_COMPTES_BANCAIRES">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_CONSULTATION_NAT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:ARCHIMED-BAPI:CONSULTATION_NAT</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_1">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Maps</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruitRestToSoapVm</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_KPS</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Mtom</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruitRestToSoap</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxGetAnimaux</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Ancre</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetCalories</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Throttle</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_ListerBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_RecupererBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_LancerBatch</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxInfobase</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxFruits</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_2">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PutFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_3">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SOAP</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_MtomUpload</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_MtomDownload</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_SxPostAnimaux</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Recaptcha</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_4">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_DeleteFruit</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_TECH</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_5">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetClient</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_GetCompteAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Operations</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_6">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PostClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_Virement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PostCompteAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_7">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_PutClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_ARCHIMED-BAPI_8">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Archdemo_DeleteClientAnais</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_NAT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_ARCHIMED-SAMPLE"/>
</Policy>
','ARCHIMED-BAPI','{"allow":[{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_CONSULTATION_TECH"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES","ARCHIMED-DEMO:CONSULTATION_NAT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_CONSULTATION_COMPTES_BANCAIRES"},{"result":[{"values":["DEFAULT:ARCHIMED-BAPI:CONSULTATION_NAT"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_CONSULTATION_NAT"},{"match":[{"values":["Archdemo_Maps","Archdemo_GetFruitRestToSoapVm","Archdemo_KPS","Archdemo_Mtom","Archdemo_GetFruitRestToSoap","Archdemo_SxGetAnimaux","Archdemo_GetFruit","Archdemo_Ancre","Archdemo_GetCalories","Archdemo_Throttle","Archdemo_ListerBatch","Archdemo_RecupererBatch","Archdemo_GetFruits","Archdemo_LancerBatch","Archdemo_SxInfobase","Archdemo_SxFruits"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_1"},{"match":[{"values":["Archdemo_PutFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_2"},{"match":[{"values":["Archdemo_SOAP","Archdemo_MtomUpload","Archdemo_MtomDownload","Archdemo_SxPostAnimaux","Archdemo_Recaptcha"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_3"},{"match":[{"values":["Archdemo_DeleteFruit"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_TECH"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_4"},{"match":[{"values":["Archdemo_GetClient","Archdemo_GetClientAnais","Archdemo_GetCompteAnais","Archdemo_Operations"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_5"},{"match":[{"values":["Archdemo_PostClientAnais","Archdemo_Virement","Archdemo_PostCompteAnais"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_6"},{"match":[{"values":["Archdemo_PutClientAnais"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_7"},{"match":[{"values":["Archdemo_DeleteClientAnais"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["ARCHIMED-DEMO:CONSULTATION_NAT","ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_ARCHIMED-BAPI_8"}],"deny":[{"id":"deny_for_ARCHIMED-SAMPLE"}],"description":"Policy pour ARCHIMED-BAPI","id":"Policy_ARCHIMED-BAPI_v1.0","target":[{"values":["ARCHIMED-BAPI"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["Archdemo_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="INTERCO-RGA" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour AMME-MIG-RGA</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">/test/v1/backend/interco</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ARCHIMED-BAPI</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">.*</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:subject" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PortAnnabelProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit2">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">InteropsProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">CONSULTATION-RAAM-TI2|CONSULTATION-RAAM-TI</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:pagm" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:BEAE:BEAE_ACCES_DECLTI</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit3">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">ArchimedDMZProvider</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:externe:provider" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:BEAE:BEAE_ACCES_DECLTI</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
</Policy>
','INTERCO-RGA','{"allow":[{"match":[{"values":["GET"],"type":"match_method"},{"values":[".*"],"type":"match_front_ext_subject"},{"values":["PortAnnabelProvider"],"type":"match_front_ext_provider"}],"id":"permit"},{"result":[{"values":["DEFAULT:BEAE:BEAE_ACCES_DECLTI"],"type":"result_authorization_back"}],"match":[{"values":["GET","POST"],"type":"match_method"},{"values":["InteropsProvider"],"type":"match_front_ext_provider"},{"values":["CONSULTATION-RAAM-TI2|CONSULTATION-RAAM-TI"],"type":"match_front_ext_pagm"}],"id":"permit2"},{"result":[{"values":["DEFAULT:BEAE:BEAE_ACCES_DECLTI"],"type":"result_authorization_back"}],"match":[{"values":["GET","POST"],"type":"match_method"},{"values":["ArchimedDMZProvider"],"type":"match_front_ext_provider"}],"id":"permit3"}],"description":"Policy pour AMME-MIG-RGA","id":"INTERCO-RGA","target":[{"values":["\/test\/v1\/backend\/interco"],"type":"match_path_equals"},{"values":["ARCHIMED-BAPI"],"type":"match_scope"}]}');
INSERT INTO "keyspace_pss_pss"."police"("dataxacml","id","datajson") VALUES ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Policy PolicyId="Policy_PASSTECH-BE_v1.0.6" RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-unless-permit" Version="1.0" xmlns="urn:oasis:names:tc:xacml:3.0:core:schema:wd-17">
    <Description>Policy pour PASSTECH-BE</Description>
    <Target>
        <AnyOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
            <AllOf>
                <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_*</AttributeValue>
                    <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                </Match>
            </AllOf>
        </AnyOf>
    </Target>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_CONSULTATION">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_CONSULTATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_CONSULTATION_COMPTE">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION_COMPTE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_CONSULTATION_UTILISATEUR</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_ADMINISTRATION">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_ADMIN_DEV">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_CONFIGURATION_MOE</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_ADMIN_EXPLOITANT">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH-BE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_PROD</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_CONFIGURATION_EXPLOITANT</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_1">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ApplicationsArchimed</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetPolicy</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetEnvironnementSimple</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_DroitsFrontend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ServicesBackend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ApplicationsArchimedNoCache</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION_COMPTE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_FORM</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_2">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetJournalVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetEnvironnement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetJournal</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_3">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PostEnvironnement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_4">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PutEnvironnement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_5">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_DeleteEnvironnement</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
        <AdviceExpressions>
            <AdviceExpression AdviceId="fr:recouv:securite:archimed:back:authorization" AppliesTo="Permit">
                <AttributeAssignmentExpression AttributeId="fr:recouv:securite:archimed:back:authorization">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION</AttributeValue>
                </AttributeAssignmentExpression>
            </AdviceExpression>
        </AdviceExpressions>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_6">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PostJournal</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION_COMPTE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_7">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PostJournalVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_SaveConfigApplicationBackend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_SaveConfigApplicationFrontendInterne</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PostVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_SaveConfigApplicationFrontendExterne</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">POST</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_FORM</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_8">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ComptesTechniques</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ConfigAppFrontendInt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ProvidersInternes</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ConfigFrontend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ConfigApplicationBackend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ApplicationsUser</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetVersionsApplication</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ScenarioTechInt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GenerateOceanKey</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ScopesInternes</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_FrontendsOfBackend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_AvailableType</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ConfigBackend</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GetVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ScenarioTechExt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_GeneratePrismeKey</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ConfigAppFrontendExt</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_ProvidersExternes</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_FORM</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_9">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_DroitsUser</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">GET</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:CONSULTATION_COMPTE</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_FORM</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_10">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_PutVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PUT</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_CSPP</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_FORM</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_VAL</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_SDIT</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Permit" RuleId="permit_for_PASSTECH-BE_11">
        <Target>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PassTech_DeleteVersion</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:resource" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">DELETE</AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
                        <AttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="false"/>
                    </Match>
                </AllOf>
            </AnyOf>
            <AnyOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMIN_DEV</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
                <AllOf>
                    <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-regexp-match">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">PASSTECH:ADMINISTRATION</AttributeValue>
                        <AttributeDesignator AttributeId="fr:recouv:securite:archimed:front:interne:droit" Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" DataType="http://www.w3.org/2001/XMLSchema#string" MustBePresent="true"/>
                    </Match>
                </AllOf>
            </AnyOf>
        </Target>
    </Rule>
    <Rule Effect="Deny" RuleId="deny_for_PASSTECH-BE"/>
</Policy>
','PASSTECH-BE','{"allow":[{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_CONSULTATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PASSTECH:CONSULTATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_CONSULTATION"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_CONSULTATION_UTILISATEUR"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PASSTECH:CONSULTATION_COMPTE"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_CONSULTATION_COMPTE"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_ADMINISTRATION"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_CONFIGURATION_MOE"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PASSTECH:ADMIN_DEV"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_ADMIN_DEV"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_CONFIGURATION_EXPLOITANT"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PASSTECH:ADMIN_SDIT","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_PROD"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_ADMIN_EXPLOITANT"},{"match":[{"values":["PassTech_ApplicationsArchimed","PassTech_GetPolicy","PassTech_GetEnvironnementSimple","PassTech_DroitsFrontend","PassTech_ServicesBackend","PassTech_ApplicationsArchimedNoCache"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:CONSULTATION_COMPTE","PASSTECH:ADMIN_DEV","PASSTECH:CONSULTATION","PASSTECH:ADMINISTRATION","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_FORM","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_SDIT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_1"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PassTech_GetJournalVersion","PassTech_GetEnvironnement","PassTech_GetJournal"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_2"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PassTech_PostEnvironnement"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_3"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PassTech_PutEnvironnement"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_4"},{"result":[{"values":["DEFAULT:PASSTECH-BE:ACCES_ADMINISTRATION"],"type":"SCOPE_AT_JWT_CLAIM_RESULT_ATTRB"}],"match":[{"values":["PassTech_DeleteEnvironnement"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_5"},{"match":[{"values":["PassTech_PostJournal"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:CONSULTATION_COMPTE","PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_6"},{"match":[{"values":["PassTech_PostJournalVersion","PassTech_SaveConfigApplicationBackend","PassTech_SaveConfigApplicationFrontendInterne","PassTech_PostVersion","PassTech_SaveConfigApplicationFrontendExterne"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["POST"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMIN_DEV","PASSTECH:ADMINISTRATION","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_FORM","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_SDIT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_7"},{"match":[{"values":["PassTech_ComptesTechniques","PassTech_ConfigAppFrontendInt","PassTech_ProvidersInternes","PassTech_ConfigFrontend","PassTech_ConfigApplicationBackend","PassTech_ApplicationsUser","PassTech_GetVersionsApplication","PassTech_ScenarioTechInt","PassTech_GenerateOceanKey","PassTech_ScopesInternes","PassTech_FrontendsOfBackend","PassTech_AvailableType","PassTech_ConfigBackend","PassTech_GetVersion","PassTech_ScenarioTechExt","PassTech_GeneratePrismeKey","PassTech_ConfigAppFrontendExt","PassTech_ProvidersExternes"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMIN_DEV","PASSTECH:ADMINISTRATION","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_FORM","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_SDIT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_8"},{"match":[{"values":["PassTech_DroitsUser"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["GET"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:CONSULTATION_COMPTE","PASSTECH:ADMIN_DEV","PASSTECH:ADMINISTRATION","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_FORM","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_SDIT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_9"},{"match":[{"values":["PassTech_PutVersion"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["PUT"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMIN_DEV","PASSTECH:ADMINISTRATION","PASSTECH:ADMIN_CSPP","PASSTECH:ADMIN_FORM","PASSTECH:ADMIN_VAL","PASSTECH:ADMIN_SDIT"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_10"},{"match":[{"values":["PassTech_DeleteVersion"],"type":"OPERATION_ID_RESOURCE_TYPE"},{"values":["DELETE"],"type":"VERB_HTTP_ACTION"},{"values":["PASSTECH:ADMIN_DEV","PASSTECH:ADMINISTRATION"],"type":"ANAIS_HAB_SUBJECT"}],"id":"permit_for_PASSTECH-BE_11"}],"deny":[{"id":"deny_for_PASSTECH-BE"}],"description":"Policy pour PASSTECH-BE","id":"Policy_PASSTECH-BE_v1.0.6","target":[{"values":["PASSTECH-BE"],"type":"SCOPES_RESOURCE_TYPE"},{"values":["PassTech_*"],"type":"OPERATION_ID_RESOURCE_TYPE"}]}');CREATE TABLE keyspace_pss_pss.application (
    name text,
    anaisappkeyocean text,
    anaisappkeyprisme text,
    description text,
    externalconfig text,
    externalscope text,
    internalmapping text,
    interopsconfig text,
    oceanconfig text,
    password_app text,
    serviceuri text,
    type text,
    userpkcs12 text,
    PRIMARY KEY (name)
) WITH read_repair_chance = 0.0
    AND dclocal_read_repair_chance = 0.1
    AND gc_grace_seconds = 864000
    AND bloom_filter_fp_chance = 0.01
    AND caching = { 'keys' : 'ALL', 'rows_per_partition' : 'NONE' }
    AND comment = ''
    AND compaction = { 'class' : 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
    AND compression = { 'sstable_compression' : 'org.apache.cassandra.io.compress.LZ4Compressor' }
    AND default_time_to_live = 0
    AND speculative_retry = '99.0PERCENTILE'
    AND min_index_interval = 128
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0;

CREATE INDEX application_serviceuri_idx ON keyspace_pss_pss.application (serviceuri);
INSERT INTO "keyspace_pss_pss"."application"("name","anaisappkeyprisme","userpkcs12","type","externalconfig","externalscope") VALUES ('AMME-MIG-RGA','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCMfDI6og+CTQTFJyxPeWp9918dD1REAyssQtnUiBkAAQ8W0sWsCC31jPE7VjCJUBDlMqFdGcQAIAxmpLOzSPyoqaUTBNNSK+wDywc61V1sdqHLO8+W608YtR3oANigJNa44WtJgAv9TZG6+2QkWbRK3N47WS0oGXw5f5MeIOj2rQIDAQAB','aa1f946d22ded545d195d7db710a56d642d08bb17ed3c9403b6a5e391441c30630843825859f8afb9b788037ec84921c0d08ee721b41b9255b07472915dd26648e614e4089c961bbf42edfc10456ec7c55c8ed5243e2306cee39dd6983e38fc869e11ecce071bba287e2ee1dfb96ba7270b673643447d5a21f61f9de9c658d78665fd5f0ca1883314a623d2d49c04502ea329097c57e8d053fa6bc9fa92036d41375da96f61010017a7a0ab1b4cc461d16df10f202872ae579ad88a220c167fcf0505137741cb7a9c10051f2a3fa7276dcfb650860ed13cf2b8ae9423212ad6c8320c65cc7f0507ad59f52c783e18c72400c760057160809a63e5dd8024a16f20d6d7b474750cbbb4660eb31b8944e6fde797319349ed116af458d7e3624b36f995b4d737370f380a305d0287cc532903628960647ec9a6d8e3165e73d214a979a5baec55d18cd841f3a5e73d5ca3bfb50db94a0770f8c5cf436279099536262a3a3892e0f0bd507de683d7905ffef5fd36dd6223a8ad1388a1c8aea590d47ca81b0bf326118f5858b4912d5ca437167bcd2da88164c97e0147baab30db2633a08771e4a3e3ce65facb3d1499a38209f2e4a5d70d8817065a1ac478d9d5a576ab1607e59c0cc76498f31056a30dd1633f33b034746bf8ffc2c37167aec42f8e1b1b94ec8b637e4e4be846003bb4495b910819f734aef53b9936fa7a1cffeb6b33b452bef5d4962af4f829a7ffab7dae60b673eb4ee98887b05b1a23d57b814a4a4df70e8bb0c0e0ce520ba6abc3e740150f5859e2e23e462c41f10df9ce1ebc7e4f9f88d2b26aa3e0103022e7131c883b561f1c34a85e8b2820b45579b9d7193da2b8b1117c93daa592c6600a22f0914127cfec74cf6bbed91b9b6b85dc30aef3a60b02406028b3a6dcc72261990ef95980b1124cb451dde6c132bcf109014f7e015f498852de9cb989e7d80a345a760a1bfd7dd84af3d388229fe2f57d11134c20428de15300b9b7ad48614c5ee4efa6d8b924766bf53444dac535b07f18a8fdca4d41575d72932b65c5e89df85a3bf5365b307b914b031dbb902cd6537082b40ac648c6cf671efc07667e721a7a7f69a96169cf28f46cb0268d112804119b13594d133565b70c53b418049cdaf827061b50667ecb04c286b465d338609d510afb32ef24b233755ab76f5f43ebf35d8c0b050efceb57a999fadb9ed27d41aca9705f0e11eaf51e8e6ce971695c93dc73f4c17ed788806c7b47b0d269be42e7a874e93450e3706a200ca2e0c480bd905713183c03eda62c3667a396be2d5a6ad53fb4d057a11f3d9e9e22522213a613296f93df75ab0e3a287c2f0c4ba4bc44fb97f0c2be375e164b82f5808afba295639d1291c9d1edad88aed33db454e6264e415cb8b57f738817e40252827c1e6749c4d4a40dd8a98d798b1d036e0ebd31d6457753122909c271d768cf58c5743ad7bfc0a03d4bfc096c4bcc1d7d5a52e8d4aa077b984f3f31d88d19ffa0881047e6ef62eb57ec4ea1d752d0ef8939cf2f6dc035e990814dddf8c4aa554446ea2c8d4f1f158b4df5eac46f4164b09cc275268decc97ad38c550c6070fe18429f6571e6a30db7d15eae4108e83148e56ba30','front_ext','{"redirect_uri":["http:\/\/localhost\/callback","http:\/\/localhost:9981\/recouv-oidc-provider\/callback.jsp","https:\/\/provider.gidn.recouv\/oidcp\/callback.jsp","https:\/\/provider.gidn.recouv\/oidcp\/callback","http:\/\/localhost\/callback?action=home","https:\/\/rp-localhost:9781\/relying-party\/callback.jsp","https:\/\/localhost:4200\/callback","https:\/\/localhost:4200\/callback_logout.jsp","http:\/\/localhost:4200"],"client_id_pss":"cn=USR_READ_NAT_APP_AMME-MIG-RGA,ou=AMME-MIG-RGA,ou=Applications,ou=Technique,dc=recouv","app_type":"confidential","auth":[{"client_secret":"e8d60fb18e716b147354324bedd5e58c82e70735ecb3ed270b5286d03e764be4bf01f47d1f44acfaa6ef42e699a484369787fd5ac49ec0d874a1258a11a47412","client_id":"f3bd111e-8fb4-4fbb-8000-20d857374ddc"},{"client_secret":"69a1e12f8c1c56bdb9bcc59ab62dfa0457e545d886bdd77449dbc01b8ce71f128128091baf3458afbc709f692a69420a72909108ff98dd250385fe2a5592f44e","client_id":"3cad5917-09ba-4fa5-8674-7c25c8cb3dc4"}],"app_code":"AMME-MIG-RGA"}','{"int_scope":{"beae.api":"BEAE","ae.messagerie":"DCL"},"map_int":{"DEFAULT:DCL:DCLAE_MESSAGERIE":"ae.messagerie","DEFAULT:BEAE:BEAE_ACCES_MOBILE":"beae.api"},"app_scope":"beae.api","app_code":"AMME-MIG-RGA"}');
INSERT INTO "keyspace_pss_pss"."application"("anaisappkeyocean","name","anaisappkeyprisme","userpkcs12","password_app","type","internalmapping") VALUES ('2AEB3B81CE199D14EBEAABBAAEAC4CED','ARCHIMED-SAMPLE','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCPZS/gJgdeLXlmif3XKE0PoNkueQgsGZqFjdiQpX265yDfL6f8mVDfL8Stw3m1I6wrPHbLYNTongpqyyX3extKFGkVcrwAxMjqBIbKKlQiro/M0YgDkPQ7+DPXey7lshkEJ0jmMxXHyKwcJfBF32pyjP1tivLnr2b0U/+6rslXwQIDAQAB','7ec3466eab91d3e4953c2d5bcfd552317deb750ca4147892a6db7b837f8812898d25a1f01467218cdd27dc830d967e2c7160a7554d700ad040db6e1f2de2d8a7b775e336aa5145aabf50b9dfeb5217705a59eb1a6d9cf8376dcf1976d421c8f507d0a0085fae5fc1b9a638cadc0c0eb6f575f323ff1e326eb5df41833e66e911257f258eefc4b4db84137122e10a89d6da743296f1283bc93e1749739a9d38b07bc895b4b65460cd1d74095457ede615312063de9404369c43ec3d2c40707f20a313cf64cafb49efb284a43bfb963cb9505f5a1117f1b00e195fd7d047bb7f9dd6e8f38976e90965ef7f9751e1cd48b11790d434e281644ec4af81cc27560c226abc7f96a06782a1a0f06166916f96e9ea0136504718f04a44dc99b48da177545bf97b026150e7d0542444556c25be3672b47dcf1f2f1330b6e6bc3c04890829b14883948d0530b1e96b85c3fc78cbf41c995385085aa978fb82741bf41f8cd045b30409e2917f6ad22c82ccfe7ca0a188d4f593a1371c5e557e1f9ed3cd8a2b0b26513e1039bfe7d29172de23240a2fd85b877b504c92ad715f7c899a7093960a69d7753e15aef1c70d10e128033e536e24031cd91de13834aa6c89c88c83ef9c655e938f614604e34eda33d618a93788f81c8d8b17ec0b9e3bffa7b92127654fb2a48d42fe0c01507a6c149e37685b1aac268ed299d2d7d49b5d057cecc366a636b05700bda3f53685b2c6c00b2289d883c09a237a5b46ef97cc75c666a8d591da410a8f148c01f5911cffe865fc0751437d6f7270db78b3a53344c57ca02ef7ee68c26d0dd7d11715a66d9beba8debcd7eb0ca2e3054744686ef1f96fc404e7ea3dd15e61e3ad420ee05e5e7c92d98bfad58487c38716fdebdb3f8a5c20ab42776eded88378c3f59bdd59c80fb93482337429feed31c3baa8c1b8e1f424e107ddcc5143d98f4408ab47df775f8d41a46187b7bc336b7d58b12a1a1ec778e97baddceafeb7180b2b6e5292f61ac119e356016d82caa650f7e7b2cf60efad487c277870bf3a60758d5daaa60b8784d2c30a86fd213fe34ec7db0dfdbf9f2d065d92d9decf603a15505fc76d54a92b92edc68a10201e11a4949fd9eae15a3ddc2f3bb407a4a30b78459eb2513e775caea83c8f251b71d83fcc9b13f075dfdb093f7b68e5174a57b7da0c0b4b87a9765ff04053685ad382ef77930fe780f6f92eb941ed50e864cb5fe4cc54dba459d59af25bbff503213a6085bff2d56204ef4352cf43b1aafe3d6ee4b936ed093624006a2421dc0228c9ffd952e7055058fbc441458bc20b8be09071d0786cda7f41d303cd32cd789b9e2234cb651c88eccef87a2df86fc4bb4c8623621609a497e3243df2dcf78389cc38cba0eddcb55829bb55fdecbb71d0ffb95dac685c0671021c572c5943cc80b77b5fb3775e067c693e3705dea6d4a4c36c53e80e95f25e063ada603bb29779b0a410a606b204597f8d05e4b659e283b6d608c3fa048b597a3ddd1833f8abf3f0290156531507ce14fa1971a05149aed5c060f1fc187810318375dfe2a86705f636a9f1d8673ecd9a1ab8292d95084ff8c94ed38bf2d702e17f94f9c77e7c173c67e06ed68f9a426ab8','$argon2id$v=19$m=4096,t=3,p=1$4vLA3Ol6VfoECqrmhmoQbA$IqXb9/HuW/MJ0F5tEaEJr75g0iAhMpqlHwfK+7rGVF4','backend','{"mappings":{"ARCHIMED-BAPI:CONSULTATION_NAT":["ARCHIMED-SAMPLE:CONSULTATION_SERVICE"],"ARCHIMED-BAPI:CONSULTATION_TECH":["ARCHIMED-SAMPLE:CONSULTATION_SERVICE"]},"frontends":["ARCHIMED-BAPI"],"backend":"ARCHIMED-SAMPLE","config_version":"ARCHIMED-SAMPLE_v1.1.2"}');
INSERT INTO "keyspace_pss_pss"."application"("name","anaisappkeyprisme","userpkcs12","type","externalconfig","externalscope") VALUES ('ARCHDEMO-DMZ','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDSwNdkZCgzWGwmwXwQfgvlEcLuGSPB0wiCelRV38cpyXmIzQARpB5gPK4yEcWpKHcV/W51YUpd6NQHZSm1DtA7AMmL928Q5ODNMMAiUJjWyhUeHIyL8q4YepTcc+4jadNa7j33CJlD4gnsExb39pWcghE4x99yYk6R8og5P1tswIDAQAB','327cde6fd17d924a69f1165acf7c935eb571c1cae9d068e864cbafcd0cc476ce15c684d0da602052f845551630c518a3a5798ccbedd55c07868c3e524022e1dfe22f5e3ca73c9c76f7e6d71a848975196fa67d1c0223d23995d25c19fbb1fdc89b577e22eff29a47abf7ccf912c711f7205675931c1760b39abd7b5e0284a19a1bb0eb64319095ea7790c524701eed74c9a13756e8a4983a513fc75119c467244df2a5eb951426c325d42c6767260cd96caf5330f30097e705a716aa6d18265d37c9313af661c872d5eb8a9bb886eba43bc3fe77748812c1e70b26ef68ff30e6ab9eae9f46b132214b34fe1f855402e72afc2cd28362d788939454781ac86da4729a1372d56888d0b15f0d09d76a3378f88974120736c37bb96d9d477a983e3c98c310b5a41d7f4722189712a18474a13213f73c375bf136dca10325fb15dc527c4cd6bfa4e68281ddb524d70b702f8d0fe30c0dc006112973c71d90857fbafb19fd1cd10aea903feffdac075648bfe6f0a1e7edba642f6ed3e925cefbc032047deeddc06c113d3212d25064ed00a860d0d66600280182530a0388a59f413b9d4c6c30ad68752ad5e089b05199673c652f7fbb9ce3292a6652c7bacb11dbda7b685b3bc9db9acc9d8eaa84b765e9e268b2388d49932ca46a7eb5904f8c7fd37d36e73df1078325427f9c4fa17a4c75324b231cd64cb37e0394430576d24d651da54aa4f8ce36cd40a5a2ffc2009f0d966638c7c52f75b0f622ee6dc1e69f508e8ef8539dc31cecf5e875727b28ee629896fa470784052f7a24d3c586b1e9250a946990ac075b7a9a90b33a025e30cb9e8beb113331a475a22338efdd3ca950ee585880f290fca4e215315c067c47e5a43e9c423dfa46611cb25fab9bca58bcc25515c6bd4ee21141b38a3154aa83d68cfdf7e701dc8416762d1a3e02dcae220c264fc0ad4d6b2ac946646b2ea78c97c04e5be98b75bd342349af2f427e420aa49b9cbeb626af14b4c8b786ea369ba2ad9d76d1b10e08316e388ba704207078c1cbed8d7cece227d4e167355e1bb550495f04a8aea6db5724635fd40057af9a0f107ce56eb5e4df0dcfd20e0c7494d00b793aacdc9f9b59792232af0f27b91a557c15c49e983cf506afcc2ce6b539f88f0b8bdd9f71684a16fcc8acff34d5195b66d7103b3cea22ad5de28a117a5d51d799c6bebdee367a46b3e022f4213aa21a8444d01e2682db701e6df481da46a73e4d69be85acd03d4e0f41103768acfb44a0fb87cad228e502f72c29eb6d8b687a583565b0d7afc725602ea09b1c5b43a59651e8799ea3e9e082b77e4a3b8b30528325ca5e84305be80cf732ddb2641c60405a979299e9f167f040eeb428144929c9c0c228510db39d37827c8e84185eeb3dd86edfda7d1f0be9e2b30f55c7b2e210149f97e00f24118f121adb2d4ff45337d09bfbff482c091f748d688c8a38854ef80d4d0c87aef4902dc25f8b013eecf10585ddde90b02540852426eea80d59cc23cc88e8ab28e5396c85e0a12e9a29a13b85a5bddd1a7452aedd60bd4aae13108fc36a5657d19a4b006217e0f7c8e014b7b7539becd61522b813c2ed98baa15b84d7d7c1ffdc6b0fdba804d9211067','front_ext','{"redirect_uri":["https:\/\/demo.urssaf.recouv\/archdemodmz\/login-callback","https:\/\/demo.urssaf.recouv\/archdemodmz\/refresh.html","https:\/\/demo.gidn.recouv\/archdemodmz\/login-callback","https:\/\/demo.gidn.recouv\/archdemodmz\/refresh.html","https:\/\/demo.gidn.recouv\/archdemodmz\/logout-callback","http:\/\/demo.gidn.recouv\/archdemodmz\/login-callback","http:\/\/demo.gidn.recouv\/archdemodmz\/refresh.html","https:\/\/localhost:4200\/login-callback","https:\/\/localhost:4200\/refresh.html","http:\/\/localhost\/callback?action=home","https:\/\/localhost:4200\/logout-callback","https:\/\/localhost:4200\/fc-callback","https:\/\/localhost:4200\/callback?action=home","https:\/\/rp-localhost:9781\/relying-party\/callback?action=home","https:\/\/rp-localhost:9781\/relying-party\/callback.jsp?action=home","https:\/\/demo.gidn.recouv\/archdemodmz\/fc-callback","https:\/\/rp-localhost:9781\/relying-party\/callback.jsp"],"client_id_pss":"cn=USR_READ_NAT_APP_ARCHDEMO-DMZ,ou=ARCHDEMO-DMZ,ou=Applications,ou=Technique,dc=recouv","app_type":"confidential","auth":[{"client_secret":"bbf0921a21f45be2c92b11bf15498a4169f6ed637d61dad9e34b65c20b2a5ce1f68d0af32f51865dc0fa9b346f165f875d8772041ec2c83c1eb09ec7438c85aa","client_id":"88c07730-eb17-45b3-bb64-5cc9c289e616"}],"app_code":"ARCHDEMO-DMZ"}','{"app_code":"ARCHDEMO-DMZ","app_scope":"openid bapi.consulter","int_scope":{"bapi.consulter":"ARCHIMED-BAPI"},"map_int":{"DEFAULT:ARCHIMED-BAPI:CONSULTATION_NAT":"bapi.consulter","DEFAULT:ARCHIMED-BAPI:CONSULTATION_TECH":"bapi.consulter","DEFAULT:ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES":"bapi.consulter"}}');
INSERT INTO "keyspace_pss_pss"."application"("anaisappkeyocean","serviceuri","interopsconfig","name","anaisappkeyprisme","userpkcs12","type","externalconfig","oceanconfig") VALUES ('2AEB3B81CE199D14EBEAABBAAEAC4CED','uri:service:cible','{"target":"ARCHIMED-DEMO","interops_type":"passerelle_client","interops_app_code":"ARCHIMED-DEMO","interops_config":[{"ServiceURI":"uri:service:cible","map":[{"PAGM1":"AC750G1500"},{"PAGM2":"AC750G1501"},{"PAGM1,PAGM2":"AC750G1502"}]}]}','ARCHIMED-DEMO','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwzfJ6VPDyCZYx+JOozfEWa2W/97tudby8tvxmFlRsS1L7R4l+g5IaEgT+KE0jQ/q5f52d3f818nID0MoyYYfl7v1hZXJ2QKhsb17Wd9CBMXwfiE/v3KNQ5TPnSdjLh4VvhQ/D++elTwMLjXM3syJaZhtvBI5OYsWfM9YQJU/GQwIDAQAB','a8d942bcc02f0ba975339c949dd30be1ec4daf047d17320f89db2cb9bad4504c674cb4c4cc84c1bd77bd4043a2206f2f01fd380ac23ddfb48bcf8f39c262a838f5182e7581b7c33e74e553fcc82e09170c45c3b863ae6e9d3ff774676044696983d2fe43e7b371b632669c5a00ce583114445d3448ff0ac1a4af2a12254c7be5439c7912b59ff2d867824376adf6d97e9e4fa64b4421fd39ff95d4bba5b0c13710616fa4246235947da7f0aef9d2a7639a4d3c4283e10e861f90984a20d10154689f56614d35d61851d2952c4b81f183fe05f192c3ddcd7dec13fe83a387a4571de355d80bfe9cd9e06ba7750cfb29faac766d2b752564def67536780174f25f0c1c9eb5ad13a98a6f089dc0ed26253cd1d13a4b3a7c5ccd176f570ad5c557cb232dd902af43fc5cfc675794062b24ede7a734ad75ecee90c04fe69ac9de364ac609f2b1ab35f836a768aa655b70bf364290b93db621e134d5317f8545cc6f2f2f26e6753379b1bd01151d58ba2785489b8cf3425f475608b997cc8fc4b6a39e236624f0af0c5c7161fe27b1e275bb24c3c3248fa50c4831d2b005864e5ef557ed1c5e7472eef40087103a7336350fed96ed35969f0d340a5185c1e4017ab2935bf0e00e0ab85508358376c19fd55e83d61214207d87953bc147ee789c73a37d491dca60b3d1ecb6754c3b7cb55d9fb53cf7a0abd670caab561bb5686b45d7f563965d8cb98f4cf7638143a214f4aa28be18b667a8bec4790a9802bfd9b1dc88bf4cf3a90021f208fe0f746824487dc4440594b77495048772332da7480223631c974b8b0611db618093c9de200bdc3e982992e16c2fb6ce83923a3e0322f17bb8454e4790249096d5e2af1616bb87ef792af9c71fa91a222b84934d409b3b5a9f6c9ce8463d05fe33cf3c2e37014933c9ed57048387defee2a16e2703760a1f3ed17518e6aa7cb79ad6f134784c499a1d0614a75c692f44238704430c3b7dd522da2bb5693c607141188aa6989cf4a706b3a85ab27f316ff7223643b75943b8f7763afa88fe96ae103249f923473871686d36a37dae2aca49b68298ee0128a75476dacee48f05a45d177c9b13da0742953f6843e6a80df020c2ebea07f6a2c5723244c702352b33c14a26baca1342ae811661d95ce3c0754da0e9e8fb6363fa3f1ced67edbbfc087723ed43d31b27ee12dcbfd7709acf461d9dfe87091b6900fc806e1c498bd937d20e69eca95ce4bd7a145e747ff981ccb96b71622f1f4d004bd04f6d598a5a8f8bb766edbf19abe42938298126589bd0dd914b23f439852a9220d2ffec31ccab2ea7cabf649cccd4b75337d7a7b65ab042077b6461db063586c76ef0a5f4a5a0e4168c070b52a13039d366e23112e41a128ccd2b5d32956ff7060cd0607f23c5a1bf23229515958387f7edd3b730cfa8677a02fe4c92667a8348c6dfed4126269e4a1f12a2bba1ed0206b65eb784e1b9ac17c23ccb3dba4f4a01bd7881ae34e17d0fb063221c936054ccdc0ade28c7f29523179c1a03a99688e7ca373e70045cccf6061ebab3b833da1246f0e9c4bf9d5bcc492261f8c9a52651900231e652aa7f1a4beb6fabcdc911e1c3ca04cbe62731d7dcb45946e096','front_int','{"redirect_uri":["http:\/\/archdemodev.gidn.recouv\/archdemo\/implicit-callback","https:\/\/archdemodev.gidn.recouv\/archdemo\/implicit-callback","http:\/\/archdemodev.gidn.recouv\/archdemo_proxy\/prisme\/connecting","https:\/\/archdemodev.gidn.recouv\/archdemo_proxy\/prisme\/connecting","http:\/\/localhost:4200\/implicit-callback","https:\/\/localhost:4200\/implicit-callback","http:\/\/localhost:3615\/archdemo_proxy\/prisme\/connecting","https:\/\/localhost:3615\/archdemo_proxy\/prisme\/connecting","http:\/\/archdemodev.gidn.recouv\/archdemo\/retour_pss","https:\/\/archdemodev.gidn.recouv\/archdemo\/retour_pss","http:\/\/localhost:4200\/retour_pss","https:\/\/localhost:4200\/retour_pss","http:\/\/10.203.77.40\/archdemo\/implicit-callback","http:\/\/10.203.77.40\/archdemo_proxy\/prisme\/connecting","http:\/\/10.203.77.40\/archdemo\/retour_pss"],"client_id_pss":"cn=USR_READ_NAT_APP_ARCHIMED-DEMO,ou=ARCHIMED-DEMO,ou=Applications,ou=Technique,dc=recouv","app_code":"ARCHIMED-DEMO"}','{"port":"80","ntp_actif":"true","is_http":"false","keys":[{"value":"2AEB3B81CE199D14EBEAABBAAEAC4CED","end":"2020-12-31","begin":"2009-02-01"},{"value":"2AEB3B81CE199D14EBEAABBAAEAC4CED","end":"2020-12-31","begin":"2009-02-01"}],"Params":[{"ACTION_DECONNEXION":"/archdemo/deconnexion?"},{"ACTION_CONNEXION":"/archdemo"}],"target":"","serveur":"archdemo.urssaf.recouv","droit_assistance_nationale":"","sources":[{"PORTAIL-ARCHIMED":"fr.acoss.tech.securite.blowfish2.jeton.xsd.all.FromAllToAllJeton"}]}');
INSERT INTO "keyspace_pss_pss"."application"("name","anaisappkeyprisme","userpkcs12","type","externalconfig","externalscope") VALUES ('AMME-RGA','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCw2BgOiuWsMncCcCD2ZTV3DLEI+mP0mideO6x84SlaO1kTjtnOggJjm5i1kH73I7mC27oniLTywpWbIoeU8PRBu7LpIlfqT+zWTBND7GUtixw5lVWynsudTDZJ2yLfR0IJfOCxrDCv9NQ5q9c7Z5lnz+RBcHk8VoC/01NXHIsV6QIDAQAB','0094e88199d4008a8e88dce75927863a9baac114f62fd7cc289b6a996834ed0ab3c43deb21d1030fbfbaec375a8b2244c9c0ae45ebfa3b68f7484862411f1a453385bb6c25f7b87a13d3729470e5b04e078ee398dcd1a3bb0ab02c0354b8c740c83a492b38e7727e51ef6af8c9f32c2cb77d9eb25747eb2f138a992e46b4771c038d250f6a8d9053a6ab911f07934cb535f707a13b631f194f190e2ae6418cdb99b35fd9118a2efc64380dea78df69dcb673883efc79274d4d7cea0a0a07cd4a5927700515be04ac54e7964446f11c32579943f05d9190999b441cde0610d8f5f117762183bb2b694a6336d9bb9ed652e661b1f67bc1347d6f3a6bb326e4d1143a702c443aab547db1caf4e04be5379490feda30714f82a45b3b1ad1a3ee6b07a8295f0adeeede45867c495e5dd43fc7afd46d7f3f23ebe1787e83c4c1985ef0ebc85b2918254a89ac389cb2c339f7c1b3616d2eb4d2133bba3d072f6896628f77cd821cbe720b87b13e2936727300f2b5cbf9800a2683a5212dbba48ff861794a87946bf2bf3709c9c2edcf40f8c6ebe562656bae8e6eb4e6398beb993aab3a4042747ace4635441497bd357a0815700116f2d136c25455547b0590687c97f3a31587527b3933f04e40d93c5a36643e314430670dd7fc45883d57802a2de7a376dddf230169cfb3e111ce26cfe956cb81fed288b95c21c14148d704420b6cfd468251769b624bd848f68c9c2ce27d7e34c0f0dd66b0e2e53931d227216d7f3dd8507cfa4b528909d71c6d24fc637f27791a089cd209d980485368e9493693e56e9ba52f4b17c04369d57b28f3c1c2f11bf4b72e8f4e8c29f0bcc8f17456bdbac689f70cba0f59490dfa950c09e855a53208c624857a411ab8249f54774f34fb99471b9bdfdd5bab38c078ba96f46c4e8b0996ae6fdf1d884a1f28148f9f380bb71b10788569658adee8d21800b431c6a689c1219e66df73eba570edf58a7e08b3f39f40e74a48bea6dad90bf1fecf3b069f6f59697747688bea7429d34015a6781b1e828b9bfd0ae6a23109044fb365f3449e0c5a5b765aff558d9c647d275257f8557545e9ea23912c01a39b2889b21bc634d8bbae8b824c9fe74f1827047c3c0152e721cdaf9ff344643528113f60b6bc8852751af0bbabfa3c0259fa73609551349d69db4aa094dabb08d0283488af69740e0dc3118d51a0b602c682e77a8dc0085167d2fd528ed1953663e4007453fed2e934d14a1683654098a7eb766f8f82d7f1d4e680ed37c51f9dac772c0072b40728480e80b3f8ba1c46f4591c86de310244483574c35110261d59c597146146bcc1f1e34410627871a105c0ffc2c084c3decc88692e1a02c703fd7452dfb52f75c26a1870fc925e546853ad0df875315e513caaecd6cf291175cae70ffd603bdcbf49d3d31175944a8f50b256ffaa6444b9ba79e2afa98eea1e8042c91879528527a72b6313fc1322f825663b1ce962ae6d47cfd73e8091bcfbe8cfadabc9681906566412b744ac1cf232b6480f5f9fe5cc52c4d5fe045a1d8550a5007531f1dd9a77872f4ddb7df19581aad4a3a4dcbe6c79bad9fc663c659fcc0726bd54d71f456a8bc4cdfa893d4ff15cd3fb','front_ext','{"redirect_uri":["http:\/\/localhost:9981\/recouv-oidc-provider\/callback.jsp","http:\/\/hwi69gidnmedserfoweb1.cer69.recouv\/oidcp\/callback.jsp","http:\/\/www.testacosss.recouv","http:\/\/www.testacosss2.recouv","http:\/\/www.testacosss.recouv","http:\/\/www.testacosss2.recouv"],"client_id_pss":"cn=USR_READ_NAT_APP_AMME-RGA,ou=AMME-RGA,ou=Applications,ou=Technique,dc=recouv","auth":[{"client_secret":"1d2f1627dd3ed804e26b09bd059865b43a4aba2eadbde9a0426437cf7e44714bb2d31f7c63998aff1dd05398d478cee335b56accd26e025e885d841abd0ae174","client_id":"b6463ded-7edd-488f-8f39-7954a4c8cfc6"},{"client_secret":"43d14c8937815b3ec7a7cb013a33bb52ab8e9a48cbc14bc49c48e6ea73f67cb00815268b7c73af6fe2ccdf8a0fad548ed1ed9373cca338dbbf2eff8016889297","client_id":"9c6b0272-8298-47a8-9c77-5cd5058ab4c2"}],"app_code":"AMME-RGA"}','{"app_code":"AMME-RGA","app_scope":"openid teledep.READ ae.messagerie","int_scope":{"ae.messagerie":"DCL"},"map_int":{"DEFAULT:DCL:DCLAE_MESSAGERIE":"ae.messagerie"}}');
INSERT INTO "keyspace_pss_pss"."application"("anaisappkeyocean","name","anaisappkeyprisme","userpkcs12","password_app","type","internalmapping") VALUES ('2AEB3B81CE199D14EBEAABBAAEAC4CED','ARCHIMED-BAPI','MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB8HuwVjwwRLxXDl2bdVCVCKCPSj5QLlAMxAIPPX2jKPG2DXHSkFeQummSRPOqqfwvxCjwJHVUsJAqY3SHHhmYd8mKse9O0tuYqbBeo96auKSU6e0QJWDdlbnc+pZwZFwK46qOOeBg2fRWpfXJuvtdPHdYyB/4Y/0trNbJmVMqNwIDAQAB','8f264705746ae32abb3231e8b14143824cd60b7c0411ba1f43b652d5457fdeabcb25ba449dcd5a2d0cd43de3fe19bea131a7bad07bd391a5bf1bbcc9393a54487992380661df5480cbdbd132e4b30591d58affebd244fbf5f5935ab7f84f9dc19af51c584a4d2179a38318b0a675a7d12dcfd93f2e37ade17b963d1b585c475454e7e0adc0660c6b085b7ff64d69e8c0dbd9019a811bdf45bbeb8c39b19ab6ae24eeff2fffbd79f94b72eb317a5a72a422a12730c584a3cc10ee881988b550fade834007f72518b217c0d90f3412a40f286a1255fd80ffb22e26545be192aa393f737ff7b6105f173881f91f5992f3d1d42b180573af241f6828f4b63230e43a53dbd94a1df2354587552de526293e1fb24dc1819f96389a2e13ed3adef64f9345d81f12493936d188584dcb8fddb28c8fe8c6df0b287bfce1447812895c57b692dedc300827c9e2b56a847fe732bf3f72bc0a63299b7bda0fd354426c441314b7b85422011f740702b056e32628cb4a11ae3dc3cd8327a780e17182ee7b37cb079132590b8d1abeae6e61734218a12b56f62e8c8b26f678fc06b1c2e06e6a03478ee3a9d6325bced1e9760c8c66230bda1d852ff6f9b3e20f0aa350039510a8fbb0ca1badddc9778491fa389fbd5c9a45de89506c07e6a8459a151e097130b2fa66c0d205b526ad5277f31e82291a721359b38f4bb8a13b85467de9aab6231e723f4b33f2ca1a6adc292b1f81c432dd614d0bff22102ab0ba63dd4f2286dcfefe793d0cf1f41bbcfeac77d8c107e0db523c4b376eadbbfe2f90e55786e1db0d273fd705182003cb519bd81d72353485c666d26c234bb91aedbfee41c25948f2bc507fcb3a02a123e1c17fd85617693155aab4900f6bb909be34e5e874b200032b87e4d807b44e621552bbbb777001b9ab9e5b47541c9e9997fca0e7380b0dc269897ffcdb186764380bfbe7263d0fe5742484cdc8866e31fb709e846679a5247b38a0ccd741f9f8c4b9830a91c574e49edb1e432252f775fe36e762246eac56b282bf94f8d1cbaed94afd8a83bd98f2e361afe4fd474cefb407c6512f49bb84093fddfe8096fdc42151ce9051bfe9a01e632592d8b0d52138a79e0322a8878230573d7ed24d1d30975a9ca0f33c52c318c028b0f79eed5ec7c3817bf2ac93a9961ec3fcf7cd95468930c3d391413f88dd726c5b41364086ba6425483733ef16ed6ac1635e20e5e228fed03c73fff3c9b1b2e9c50a44fccd360559a088f7307f59d70d8e6703c84136129a98ca344aac8cf9166b726e69d0a8468c4d58b7f1bacd4999b5093506d710f923d38c8bfe662c38b7073559daf8b3c49a7f45995afed5a1db1d5c5e2ac97a1fcb99b6924641a43eea6bbc8136dd0593b8c8d92cfa3cc1c86ec0ae1851a50dd950c3a9f3e8b0d4d02ed79cb7b8071fbeb01cc13640b2ac652f014224f314a3227f65ddfd484254da39fc4d465fc125f439bb6a56eb47f57fd14c655ecd0ea8d01c3cd055575f6ecb281286bbe2179046bc0f6bad3db633f2930ec88c994595a3dccf67668efe175ecf2467514518e3353e2a265a86d1a798bf11d0308df272019d3d4b6720398e253f968bc13559cf8580ec44dbe132','$argon2id$v=19$m=4096,t=3,p=1$knBtA2PP3lg0y5RagN5iKg$k+PJIzj/Qf0BViF4V3Q4uC2sgfwa4HAx/cUuNZMx0LE','backend','{"mappings":{"ARCHIMED-DEMO:CONSULTATION_TECH":["ARCHIMED-BAPI:CONSULTATION_TECH"],"ARCHIMED-DEMO:CONSULTATION_NAT":["ARCHIMED-BAPI:CONSULTATION_NAT"],"ARCHIMED-DEMO:CONSULTATION_COMPTES_BANCAIRES":["ARCHIMED-BAPI:CONSULTATION_COMPTES_BANCAIRES"]},"frontends":["ARCHIMED-DEMO"],"backend":"ARCHIMED-BAPI","config_version":"ARCHIMED-BAPI_v1.1.2"}');