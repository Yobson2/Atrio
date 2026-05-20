import { Entity, Column } from 'typeorm';
import { BaseEntity } from '@common/database/base.entity';

export enum BookingStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
  RESCHEDULED = 'rescheduled',
}

@Entity('bookings')
export class Booking extends BaseEntity {
  @Column()
  salonId: string;

  @Column()
  clientId: string;

  @Column()
  serviceId: string;

  @Column({ nullable: true })
  barberId: string;

  @Column({ type: 'date' })
  date: string;

  @Column({ type: 'time' })
  startTime: string;

  @Column({ type: 'time', nullable: true })
  endTime: string;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  totalPrice: number;

  @Column({
    type: 'enum',
    enum: BookingStatus,
    default: BookingStatus.PENDING,
    enumName: 'booking_status_enum',
  })
  status: BookingStatus;

  @Column({ type: 'text', nullable: true })
  notes: string;

  // Denormalized fields for fast reads
  @Column({ nullable: true })
  salonName: string;

  @Column({ nullable: true })
  serviceName: string;

  @Column({ nullable: true })
  barberName: string;

  @Column({ nullable: true })
  salonAddress: string;

  @Column({ nullable: true })
  serviceDuration: number;

  @Column({ type: 'timestamptz', nullable: true })
  cancelledAt: Date;
}
