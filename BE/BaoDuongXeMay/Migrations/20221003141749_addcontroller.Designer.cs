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
    [Migration("20221003141749_addcontroller")]
    partial class addcontroller
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
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("isAdmin")
                        .HasColumnType("bit");

                    b.HasKey("IdUser");

                    b.ToTable("Users");
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

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.CategoryVehicle", "CategoryVehicle")
                        .WithMany("Vehicles")
                        .HasForeignKey("CategoryVehicleID");

                    b.Navigation("CategoryVehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Navigation("Vehicles");
                });
#pragma warning restore 612, 618
        }
    }
}