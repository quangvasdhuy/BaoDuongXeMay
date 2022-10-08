﻿// <auto-generated />
using System;
using BaoDuongXeMay.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace BaoDuongXeMay.Migrations
{
    [DbContext(typeof(MyDbContext))]
    [Migration("20221008010304_config")]
    partial class config
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.10")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BaoDuongXeMay.Data.Accessary", b =>
                {
                    b.Property<Guid>("AccessaryID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("AccessaryName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("AccessaryID");

                    b.ToTable("Accessaries");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Property<Guid>("CategoryVehicleID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("CategoryVehicleName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("CategoryVehicleID");

                    b.ToTable("CategoryVehicles");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetaillNAU", b =>
                {
                    b.Property<Guid>("AccessaryID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("UnitID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("VehicleID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("CountPerforation")
                        .HasColumnType("int");

                    b.Property<int>("Km_Max")
                        .HasColumnType("int");

                    b.Property<int>("Km_Min")
                        .HasColumnType("int");

                    b.HasKey("AccessaryID", "UnitID", "VehicleID");

                    b.HasIndex("UnitID");

                    b.HasIndex("VehicleID");

                    b.ToTable("DetailNAU");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Unit", b =>
                {
                    b.Property<Guid>("UnitID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("UnitName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UnitID");

                    b.ToTable("Units");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.User", b =>
                {
                    b.Property<Guid>("IdUser")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(250)
                        .HasColumnType("nvarchar(250)");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("IdUser");

                    b.HasIndex("Username")
                        .IsUnique();

                    b.ToTable("User");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.Property<Guid>("VehicleID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("CategoryVehicleID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VehicleName")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.HasKey("VehicleID");

                    b.HasIndex("CategoryVehicleID");

                    b.ToTable("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetaillNAU", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.Accessary", "Accessary")
                        .WithMany("DetailNaus")
                        .HasForeignKey("AccessaryID")
                        .HasConstraintName("FK_Accessary_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.Unit", "Unit")
                        .WithMany("DetailNaus")
                        .HasForeignKey("UnitID")
                        .HasConstraintName("FK_Unit_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.Vehicle", "Vehicle")
                        .WithMany("DetailNaus")
                        .HasForeignKey("VehicleID")
                        .HasConstraintName("FK_Vehicle_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Accessary");

                    b.Navigation("Unit");

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.CategoryVehicle", "CategoryVehicle")
                        .WithMany("Vehicles")
                        .HasForeignKey("CategoryVehicleID");

                    b.Navigation("CategoryVehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Accessary", b =>
                {
                    b.Navigation("DetailNaus");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Navigation("Vehicles");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Unit", b =>
                {
                    b.Navigation("DetailNaus");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.Navigation("DetailNaus");
                });
#pragma warning restore 612, 618
        }
    }
}
